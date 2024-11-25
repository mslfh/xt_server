import { ActionContext, ActionRequest } from 'adminjs';

import UserEvents from '../db/models/userEvents.js';

const CreateUserEventsResource = {
    resource: UserEvents,
    options: {
        properties: {
            ID: {
                isVisible: {
                    list: true,
                    filter: true,
                    show: true,
                    edit: false,
                },
            },
            UserID: {
                isVisible: true,
            },
            // ExerciseCategoryID: { reference: 'exercise_category', isVisible: true },
            // ExerciseID: { reference: 'exercise', isVisible: true },
        },
        actions: {
            list: {
                hideActionHeader: true,
                isVisible: true,
                showFilter: false,
                component: 'UserEvents',
                before: async (request: ActionRequest, context: ActionContext) => {
                    const userEvents = await UserEvents.findAll();
                    const formattedEvents = userEvents.map((item) => ({
                        id: item.ID,
                        title: item.EventType.toString(),
                        start: item.Date,
                        end: item.Date,
                    }));
                    context.extraProps = { events: formattedEvents };
                },
            },
        },
    },
};
export default CreateUserEventsResource;
