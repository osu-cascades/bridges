<template>
  <div class="organizations-dashboard">
    <div class="jumbotron center">
      <h1 class="text-center">Bridging Out-of-School Time</h1>
      <p class="text-center">A catalog of after school, weekend, and summer activities for children and young adults in the High Desert Education Service District.</p>
      <form class="form-inline search">
        <input class="col-md-6 form-control" type="text" placeholder="Search..." v-model="search"></input>
      </form>
      <div class="section tags">
        <button v-for="tag in tagsData" v-on:click="select(tag)" v-bind:class="active(tag)" class="btn btn-secondary btn-sm">{{ tag.name }}</button>
      </div>
      <div class="section tags">
        <button v-on:click="clearTags" class="btn btn-primary btn-sm">Clear Tags</button>
      </div>
    </div>
    <nav class="subnav">
      <a class="btn btn-primary" title="Add a new organization" href="/organizations/new">Add Organization</a>
      <button v-on:click="toggleView" title="Toggle view" class="btn btn-primary">View as {{ view === 'card' ? 'list' : 'cards' }}</button>
    </nav>
    <div class="container" v-if="admin && view === 'card'">
      <OrganizationCard organizationState="pending" :organizations="pendingOrganizationsData" :admin="admin"></OrganizationCard>
    </div>
    <div class="container" v-if="admin && view === 'list'">
      <OrganizationList organizationState="pending" :organizations="pendingOrganizationsData" :admin="admin"></OrganizationList>
    </div>
    <div class="container" v-if="view === 'card'">
      <OrganizationCard organizationState="active" :organizations="organizationsData" :admin="admin"></OrganizationCard>
    </div>
    <div class="container" v-if="view === 'list'">
      <OrganizationList organizationState="active" :organizations="organizationsData" :admin="admin"></OrganizationList>
    </div>
    <div class="container" v-if="admin && view === 'card'">
      <OrganizationCard organizationState="denied" :organizations="deniedOrganizationsData" :admin="admin"></OrganizationCard>
    </div>
    <div class="container" v-if="admin && view === 'list'">
      <OrganizationList organizationState="denied" :organizations="deniedOrganizationsData" :admin="admin"></OrganizationList>
    </div>
  </div>
</template>

<script>
import { eventBus } from '../packs/organizations';
import OrganizationCard from './organization_card';
import OrganizationList from './organization_list';
import axios from 'axios';

export default {
  props: {
    organizations: {
      type: Array,
      required: true
    },
    tags: {
      type: Array,
      required: true
    },
    pendingOrganizations: {
      type: Array
    },
    deniedOrganizations: {
      type: Array
    },
    admin: {
      type: Boolean,
      required: true
    }
  },
  data: function () {
    return {
      search: '',
      selected_tags: [],
      tagsData: this.tags,
      organizationsData: this.organizations,
      pendingOrganizationsData: this.pendingOrganizations,
      deniedOrganizationsData: this.deniedOrganizations,
      view: 'card'
    }
  },
  methods: {
    select: async function (tag) {
      const indexOfTag = this.selected_tags.indexOf(tag.name);
      indexOfTag === -1 ?
        this.selected_tags.push(tag.name) :
        this.selected_tags.splice(indexOfTag, 1);
      const { data } = await axios.get('/organizations.json', { params: { tags: this.selected_tags }, headers: { 'Content-Type': 'application/json' } });
      this.organizationsData = data.organizations;
      eventBus.$emit('active_organizations_updated', this.organizationsData);
    },
    clearTags: async function () {
      const { data } = await axios.get('/organizations.json', { headers: { 'Content-Type': 'application/json' } });
      this.organizationsData = data.organizations;
      this.selected_tags = [];
      eventBus.$emit('active_organizations_updated', this.organizationsData);
    },
    active: function (tag) {
      return this.selected_tags.includes(tag.name)  ? 'active' : '';
    },
    toggleView: function () {
      this.view = this.view === 'card' ? 'list' : 'card';
    }
  },
  watch: {
    search: _.debounce(async function (val) {
      const { data } = await axios.get('/organizations.json', { params: { tags: this.selected_tags, search: val }, headers: { 'Content-Type': 'application/json' } });
      this.organizationsData = data.organizations;
      eventBus.$emit('active_organizations_updated', this.organizationsData);
    }, 1000)
  },
  components: {
    OrganizationCard,
    OrganizationList
  }
}
</script>
