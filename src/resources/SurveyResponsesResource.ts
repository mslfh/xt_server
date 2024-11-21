import SurveyResponse from '../db/models/surveyResponse.js';

const CreateSurveyResponsesResource = {
    resource: SurveyResponse,
    options: {
        properties: {
            ID: {
                position: 1,
                isVisible: {
                    list: true, filter: true, show: true, edit: false,
                },
            },
            UserID: {
                position: 2,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            Date: {
                position: 3,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            DaysWorked: {
                position: 4,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            HoursWorked: {
                position: 5,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            PercentSitting: {
                position: 6,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            PercentStanding: {
                position: 7,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            PercentWalking: {
                position: 8,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
            PercentHeavy: {
                position: 9,
                isVisible: {
                    list: true, filter: true, show: true, edit: true,
                },
            },
        },
        actions: {
            new: {
                before: async (request) => request,
            },
        },
    },
};

export default CreateSurveyResponsesResource;
