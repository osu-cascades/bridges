import Vue from 'vue/dist/vue.esm'
import _ from 'lodash';

import OrganizationCard from '../components/organization_card'
import OrganizationList from '../components/organization_list'
import OrganizationsDashboard from '../components/organizations_dashboard'

export const eventBus = new Vue();

Vue.component('organization_card', OrganizationCard);
Vue.component('organization_list', OrganizationList);
Vue.component('organizations_dashboard', OrganizationsDashboard);

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: '#dashboard'
  })
});
