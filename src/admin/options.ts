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
import UserMicrosoftAccount from '../db/models/microsoftAccount.js';


const options: AdminJSOptions = {
  componentLoader,
  rootPath: '/admin',
  resources: [
    {
      resource: Organisation,
      options: {
        properties: {
          ShortName: { isVisible: { list: true, edit: true, show: true, filter: true } },
          LongName: { isVisible: { list: true, edit: true, show: true, filter: true } },
          CountdownDuration: { isVisible: { list: true, edit: true, show: true, filter: true } },
          WalkingExDelay: { isVisible: { list: true, edit: true, show: true, filter: true } },
        },
      },
    },
    {
      resource: Department,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
          OrganisationID: { reference: 'Organisation', isVisible: true },
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
          ID: { isVisible: { list: true, filter: true, show: false, edit: false } },
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
          UserID: { reference: 'user', isVisible: true },
          ExerciseID: { reference: 'exercise', isVisible: true },
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
          UserID: { reference: 'user', isVisible: true },
          ExerciseID: { reference: 'exercise', isVisible: true },
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
          UserID: { reference: 'user', isVisible: true },
          SettingKey: { isVisible: { list: true, filter: true, show: true, edit: true } },
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
          UserID: { reference: 'user', isVisible: true },
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
          ExerciseID: { reference: 'exercise', isVisible: true },
          DepartmentID: { reference: 'department', isVisible: true },
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
          UserID: { reference: 'user', isVisible: true },
          WebAuthnUserID: { isVisible: true },
          PublicKey: { isVisible: { list: false, filter: false, show: false, edit: true } },
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
          ExerciseID: { reference: 'exercise', isVisible: true },
          UserID: { reference: 'user', isVisible: true },
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
          Type: { isVisible: true },
          EndTime: { isVisible: true },
          StartTime: { isVisible: true },
          Status: { isVisible: true },
          MaxCaption: { isVisible: true },
          MinCaption: { isVisible: true },
          Order: { isVisible: true },
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
      resource: HelpfulHints,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
          DepartmentID: { reference: 'department', isVisible: true },
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
          ExerciseLogID: { reference: 'exercise_log', isVisible: true },
          QuestionID: { reference: 'question', isVisible: true },
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
          UserID: { reference: 'user', isVisible: true },
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
          UserID: { reference: 'user', isVisible: true },
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
          UserID: { reference: 'user', isVisible: true },
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
          ID: { isTitle: true, isVisible: { list: true, filter: true, show: true, edit: false } },
          UserID: { reference: 'user', isVisible: true },
          EventID: { reference: 'user_event', isVisible: true },
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
          ExerciseID: { reference: 'exercise', isVisible: true },
          PlanID: { reference: 'exercise_plan', isVisible: true, position: 1 },
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
          ID: { isTitle: true, isVisible: { list: true, filter: true, show: true, edit: false, } },
          OrganisationID: { reference: 'Organisation', isVisible: true },
          DepartmentID: { reference: 'department', isVisible: true },
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
      resource: UserMicrosoftAccount,
      options: {
        properties: {
          ID: { isVisible: { list: true, filter: true, show: true, edit: false } },
          UserID: { reference: 'user', isVisible: true },
          microsoftEmail: { isVisible: { list: true, filter: true, show: true, edit: true } },
          oid: { isVisible: { list: true, filter: true, show: true, edit: true } },
          sub: { isVisible: { list: true, filter: true, show: true, edit: true } },
          isLinked: { isVisible: { list: true, filter: true, show: true, edit: true } },
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
  ],
  databases: [],
};

export default options;
