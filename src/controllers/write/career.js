'use strict';

const helpers = require('../helpers');
const user = require('../../user');
const db = require('../../database');

const Career = module.exports;

Career.register = async (req, res) => {
    const userData = req.body;
    try {
        const userCareerData = {
            student_id: userData.student_id,
            major: userData.major,
            age: userData.age,
            gender: userData.gender,
            gpa: userData.gpa,
            extra_curricular: userData.extra_curricular,
            num_programming_languages: userData.num_programming_languages,
            num_past_internships: userData.num_past_internships,
        };

        try {
            // deployed url for the microservice
            const deployedUrl = 'https://python-microservice-f474tbkenq-uc.a.run.app/predict';
            // sending http request to the url
            const params = new URLSearchParams(userCareerData);
            const response = await fetch(`${deployedUrl}?${params}`);
            const data = await response.json();
            // getting the prediction based on the response from the http request
            userCareerData.prediction = String(data.good_employee);
        } catch (error) {
            console.error('Error while making the HTTP request:', error);
        }

        await user.setCareerData(req.uid, userCareerData);
        db.sortedSetAdd('users:career', req.uid, req.uid);
        res.json({});
    } catch (err) {
        console.log(err);
        helpers.noScriptErrors(req, res, err.message, 400);
    }
};