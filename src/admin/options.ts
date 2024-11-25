import { AdminJSOptions } from 'adminjs';
import componentLoader from './component_loader.js';
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

import CreateVideoUploadResource from '../resources/VideoUploadResource.js';
import CreateOrganisationsResource from '../resources/OrganisationsResource.js';
import CreateDepartmentsResource from '../resources/DepartmentsResource.js';
import CreateUsersResource from '../resources/UsersResource.js';
import CreateExercisesResource from '../resources/ExercisesResource.js';
import CreateReportsResource from '../resources/ReportsResource.js';
import CreateQuestionsResource from '../resources/QuestionsResource.js';
import CreateRegistrationResource from '../resources/RegistrationResource.js';
import CreateSurveyResponsesResource from '../resources/SurveyResponsesResource.js';
import CreateUserEventsResource from '../resources/UserEventsResource.js';
import CreateHelpfulHintsResource from '../resources/HelpfulHintsResource.js';

import componentLoader from './component-loader.js';

const options: AdminJSOptions = {
  componentLoader,
  assets: {
    styles: ['/css/react-big-calendar.css'],
  },
  dashboard: {
    component: 'Dashboard',
  },
  rootPath: '/admin',
  resources: [
    CreateVideoUploadResource,
    CreateOrganisationsResource,
    CreateDepartmentsResource,
    CreateUsersResource,
    CreateExercisesResource,
    CreateReportsResource,
    CreateQuestionsResource,
    CreateRegistrationResource,
    CreateSurveyResponsesResource,
    CreateUserEventsResource,
    CreateHelpfulHintsResource,
  ],
  databases: [],
};

export default options;
