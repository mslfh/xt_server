import { AdminJSOptions } from 'adminjs';
import componentLoader from './component-loader.js';
import Organisation from '../db/models/organisation.js';
import Department from '../db/models/department.js';
import Exercise from '../db/models/exercise.js';
import User from '../db/models/user.js'; 
import ExerciseDelay from '../db/models/exerciseDelay.js';
import UserWeight from '../db/models/userWeight.js';
import ExerciseDepartment from '../db/models/exerciseDepartment.js';
import Credentials from '../db/models/credentials.js';
import ExerciseLog from '../db/models/exerciseLog.js';
import Question from '../db/models/question.js';
import HelpfulHints from '../db/models/helpfulHints.js';
import ExerciseLogQuestion from '../db/models/exerciseLogQuestion.js';
import UserPosition from '../db/models/userPosition.js';
import SurveyResponse from '../db/models/surveyResponse.js';
import UserEvents from '../db/models/userEvents.js';
import ExerciseCategory from '../db/models/exerciseCategory.js';
import ExerciseEvent from '../db/models/exerciseEvent.js';
import ExercisePlan from '../db/models/exercisePlan.js';
import UserExerciseLog from '../db/models/userExerciseLog.js';
import UserFavourite from '../db/models/userFavorite.js';
import UserSetting from '../db/models/userSettings.js';


const options: AdminJSOptions = {
  componentLoader,
  rootPath: '/admin',
  resources: [
    {
      resource: Organisation,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
        },
      },
    },
    {
      resource: Department,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
          OrganisationID: { reference: 'organisation', isVisible: true },
        },
        actions: {
          new: {
            before: async (request) => {
              if (request.payload) {
                delete request.payload.ID;
              }
              return request;
            },
          },
        },
      },
    },
    {
      resource: Exercise,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
        },
        actions: {
          new: {
            before: async (request) => {
              if (request.payload) {
                delete request.payload.ID;
              }
              return request;
            },
          },
        },
      },
    },
    {
      resource: User, 
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
          DepartmentID: { reference: 'department', isVisible: true },
          CreatedAt: { isVisible: { list: true, filter: true, show: true, edit: false } },
          UpdatedAt: { isVisible: { list: true, filter: true, show: true, edit: false } },
  
        },
        actions: {
          new: {
            before: async (request) => {
              if (request.payload) {
                delete request.payload.ID;
              }
              return request;
            },
          },
        },
      },
    },
    {
      resource: ExerciseDelay,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
          UserID: { reference: 'User', isVisible: true },
        },
        actions: {
          new: {
            before: async (request) => {
              if (request.payload) {
                delete request.payload.ID;
              }
              return request;
            },
          },
        },
      },
    },

    {
      resource: UserFavourite,
      options: {
        properties: {
          UserID: { reference: 'User', isVisible: true },
          ExerciseID: { reference: 'exercises', isVisible: true },
        },
        actions: {
          new: {
            before: async (request) => {
              if (request.payload) {
                delete request.payload.ID;
              }
              return request;
            },
          },
        },
      },
    },
    {
      resource: UserSetting,
      options: {
        properties: {
          SettingKey: { isVisible: { list: true, filter: true, show: true, edit: false } },
          SettingValue: { isVisible: true },
        },
        actions: {
          new: {
            before: async (request) => {
              return request;
            },
          },
        },
      },
    },
    {
      resource: UserWeight,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
          UserID: { reference: 'User', isVisible: true },
        },
        actions: {
          new: {
            before: async (request) => {
              if (request.payload) {
                delete request.payload.ID;
              }
              return request;
            },
          },
        },
      },
    },
    {
      resource: ExerciseDepartment,
      options: {
        properties: {
          ExerciseID: { reference: 'exercises', isVisible: true },
          DepartmentID: { reference: 'departments', isVisible: true },
        },
        actions: {
          new: {
            before: async (request) => {
              return request;
            },
          },
        },
      },
    },

    {
      resource: Credentials,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
          UserId: { reference: 'User', isVisible: true },
          WebAuthnUserID: { isVisible: true },
          PublicKey: { isVisible: true },
          Counter: { isVisible: true },
          DeviceType: { isVisible: true },
          BackedUp: { isVisible: true },
          Transports: { isVisible: true },
        },
        actions: {
          new: {
            before: async (request) => {
              if (request.payload) {
                delete request.payload.ID;
              }
              return request;
            },
          },
        },
      },
    },

    {
      resource: ExerciseLog,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
          ExerciseID: { reference: 'exercises', isVisible: true },
          UserID: { reference: 'User', isVisible: true },
        },
        actions: {
          new: {
            before: async (request) => {
              if (request.payload) {
                delete request.payload.ID;
              }
              return request;
            },
          },
        },
      },
    },
    {
      resource: Question,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
        },
        actions: {
          new: {
            before: async (request) => {
              return request;
            },
          },
        },
      },
    },

    {
      resource: HelpfulHints,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
          DepartmentID: { reference: 'departments', isVisible: true },
        },
        actions: {
          new: {
            before: async (request) => {
              return request;
            },
          },
        },
      },
    },

    {
      resource: ExerciseLogQuestion,
      options: {
        properties: {
          ExerciseLogID: { reference: 'ExerciseLog', isVisible: true },
          QuestionID: { reference: 'Question', isVisible: true },
        },
        actions: {
          new: {
            before: async (request) => {
              return request;
            },
          },
        },
      },
    },
    {
      resource: UserPosition,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
          UserID: { reference: 'User', isVisible: true },
        },
        actions: {
          new: {
            before: async (request) => {
              return request;
            },
          },
        },
      },
    },
    {
      resource: SurveyResponse,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
          UserID: { reference: 'User', isVisible: true },
        },
        actions: {
          new: {
            before: async (request) => {
              return request;
            },
          },
        },
      },
    },

    {
      resource: UserEvents,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
          UserID: { reference: 'User', isVisible: true },
        },
        actions: {
          new: {
            before: async (request) => {
              return request;
            },
          },
        },
      },
    },
    {
      resource: UserExerciseLog,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
        },
        actions: {
          new: {
            before: async (request) => {
              return request;
            },
          },
        },
      },
    },
    {
      resource: ExerciseCategory,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
        },
        actions: {
          new: {
            before: async (request) => {
              return request;
            },
          },
        },
      },
    },
    {
      resource: ExerciseEvent,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
        },
        actions: {
          new: {
            before: async (request) => {
              return request;
            },
          },
        },
      },
    },
    {
      resource: ExercisePlan,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
        },
        actions: {
          new: {
            before: async (request) => {
              return request;
            },
          },
        },
      },
    },
  ],
  databases: [],
};

export default options;
