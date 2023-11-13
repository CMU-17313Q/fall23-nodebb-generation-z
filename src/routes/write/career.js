
// this file was created using a friend's help. It sets up the route for career page.

'use strict';

const router = require('express').Router();
const controllers = require('../../controllers');
const routeHelpers = require('../helpers');
const middleware = require('../../middleware');

const { setupApiRoute } = routeHelpers;
module.exports = function () {
    const middlewares = [middleware.ensureLoggedIn];
    setupApiRoute(router, 'post', '/register', [...middlewares], controllers.write.career.register);
    return router;
};