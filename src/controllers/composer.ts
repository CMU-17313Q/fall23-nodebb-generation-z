import nconf from 'nconf';
import { Request, Response, NextFunction } from 'express';
import { TopicObject } from '../types';
import user from '../user';
import plugins from '../plugins';
import topics from '../topics';
import posts from '../posts';
import helpers from './helpers';

type ComposerBuildData = {
    templateData: TemplateData;
};

type TemplateData = {
    title: string;
    disabled: boolean;
};

type Locals = {
    metaTags: { [key: string]: string };
};

export async function get(req: Request, res: Response<object, Locals>, callback: NextFunction): Promise<void> {
    res.locals.metaTags = {
        ...res.locals.metaTags,
        name: 'robots',
        content: 'noindex',
    };

    const data: ComposerBuildData = await plugins.hooks.fire('filter:composer.build', {
        req: req,
        res: res,
        next: callback,
        templateData: {} as TemplateData,
    }) as ComposerBuildData;

    if (res.headersSent) {
        return;
    }
    if (!data || !data.templateData) {
        return callback(new Error('[[error:invalid-data]]'));
    }

    if (data.templateData.disabled) {
        res.render('', {
            title: '[[modules:composer.compose]]',
        });
    } else {
        data.templateData.title = '[[modules:composer.compose]]';
        res.render('compose', data.templateData);
    }
}

type ComposerData = {
    uid: number;
    req: Request<object, object, ComposerData>;
    timestamp: number;
    content: string;
    fromQueue: boolean;
    tid?: number;
    cid?: number;
    title?: string;
    tags?: string[];
    thumb?: string;
    noscript?: string;
};

type QueueResult = {
    uid: number;
    queued: boolean;
    topicData: TopicObject;
    pid: number;
};

type PostFnType = (data: ComposerData) => Promise<QueueResult>;

export async function post(req: Request<object, object, ComposerData & { uid: number }>, res: Response): Promise<void> {
    const { body } = req;
    const data: ComposerData = {
        uid: req.uid,
        req: req,
        timestamp: Date.now(),
        content: body.content || '', // Provide a default value to ensure content is not undefined
        fromQueue: false,
    };
    req.body.noscript = 'true';

    if (!data.content) {
        return await helpers.noScriptErrors(req, res, '[[error:invalid-data]]', 400) as Promise<void>;
    }

    async function queueOrPost(postFn: PostFnType, data: ComposerData): Promise<QueueResult> {
        const shouldQueue: boolean = await posts.shouldQueue(req.uid, data);
        if (shouldQueue) {
            delete data.req;

            return await posts.addToQueue(data);
        }
        return await postFn(data);
    }

    try {
        let result: QueueResult;
        if (body.tid) {
            data.tid = body.tid;
            result = await queueOrPost(topics.reply as PostFnType, data);
        } else if (body.cid) {
            data.cid = body.cid;
            data.title = body.title || ''; // Provide a default value for title
            data.tags = [];
            data.thumb = '';
            result = await queueOrPost(topics.post as PostFnType, data);
        } else {
            throw new Error('[[error:invalid-data]]');
        }
        if (result.queued) {
            return res.redirect(`${nconf.get('relative_path') as string || '/'}?noScriptMessage=[[success:post-queued]]`);
        }
        const uid: number = result.uid ? result.uid : result.topicData.uid;

        user.updateOnlineUsers(uid);

        const path: string = result.pid ? `/post/${result.pid}` : `/topic/${result.topicData.slug}`;
        res.redirect(`${nconf.get('relative_path') as string}${path}`);
    } catch (err) {
        if (err instanceof Error) {
            await helpers.noScriptErrors(req, res, err.message, 400);
        }
    }
}

