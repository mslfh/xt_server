import { ComponentLoader } from 'adminjs';

const componentLoader = new ComponentLoader();

componentLoader.add('Dashboard', '../components/Dashboard/index');
componentLoader.add('VideoUploadEdit', '../components/VideoUploadEditComponent/index');
componentLoader.add('OrganisationalDetail', '../components/Organisation/OrganisationDetail/index');
componentLoader.add('ExportOrganisationActivities', '../components/Organisation/ExportOrganisationActivities/index');
componentLoader.add('DepartmentMove', '../components/Department/DepartmentMove/index');
componentLoader.add('ExportUserActivities', '../components/User/ExportUserActivities/index');
componentLoader.add('UserDetail', '../components/User/UserDetail/index');
componentLoader.add('UserEvents', '../components/UserEvent/index');

export default componentLoader;
