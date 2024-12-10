import { AdminJSOptions } from 'adminjs';

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
import CreateExercisesLogResource from '../resources/ExercisesLogResource.js';

import componentLoader from './component_loader.js';

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
    // CreateVideoUploadResource,
    CreateOrganisationsResource,
    CreateDepartmentsResource,
    CreateUsersResource,
    CreateExercisesResource,
    CreateExercisesLogResource,
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
