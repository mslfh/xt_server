import UserEvents from '../db/models/userEvents.js';

const CreateUserEventsResource = {
    resource: UserEvents,
    options: {
        properties: {
            ID: {
                isVisible: {
                    list: true, filter: true, show: true, edit: false,
                },
            },
            UserID: { reference: 'user', isVisible: true },
            // ExerciseCategoryID: { reference: 'exercise_category', isVisible: true },
            // ExerciseID: { reference: 'exercise', isVisible: true },
        },
        actions: {
            list: {
                hideActionHeader: true,
                isVisible: true,
                showFilter: false,
                component: 'UserEvent',
            },
        },
    },
};
export default CreateUserEventsResource;
