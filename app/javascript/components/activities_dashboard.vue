<template>
  <div class="activities-dashboard">
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
      <a class="btn btn-primary" title="Add a new activity" href="/activities/new">Add Activity</a>
      <button v-on:click="toggleView" title="Toggle view" class="btn btn-primary">View as {{ view === 'card' ? 'list' : 'cards' }}</button>
    </nav>
    <div class="container" v-if="admin && view === 'card'">
      <ActivityCard activityState="pending" :activities="pendingActivitiesData" :admin="admin"></ActivityCard>
    </div>
    <div class="container" v-if="view === 'card'">
      <ActivityCard activityState="active" :activities="activitiesData" :admin="admin"></ActivityCard>
    </div>
    <div class="container" v-if="view === 'list'">
      <ActivityList activityState="active" :activities="activitiesData" :admin="admin"></ActivityList>
    </div>
    <div class="container" v-if="admin && view === 'card'">
      <ActivityCard activityState="denied" :activities="deniedActivitiesData" :admin="admin"></ActivityCard>
    </div>
  </div>
</template>

<script>
import { eventBus } from '../packs/activities';
import ActivityCard from './activity_card';
import ActivityList from './activity_list';
import axios from 'axios';

export default {
  props: {
    activities: {
      type: Array,
      required: true
    },
    tags: {
      type: Array,
      required: true
    },
    pendingActivities: {
      type: Array
    },
    deniedActivities: {
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
      activitiesData: this.activities,
      pendingActivitiesData: this.pendingActivities,
      deniedActivitiesData: this.deniedActivities,
      view: 'card'
    }
  },
  methods: {
    select: async function (tag) {
      const indexOfTag = this.selected_tags.indexOf(tag.name);
      indexOfTag === -1 ?
        this.selected_tags.push(tag.name) :
        this.selected_tags.splice(indexOfTag, 1);
      const { data } = await axios.get('/activities.json', { params: { tags: this.selected_tags }, headers: { 'Content-Type': 'application/json' } });
      this.activitiesData = data.activities;
      eventBus.$emit('active_activities_updated', this.activitiesData);
    },
    clearTags: async function () {
      const { data } = await axios.get('/activities.json', { headers: { 'Content-Type': 'application/json' } });
      this.activitiesData = data.activities;
      this.selected_tags = [];
      eventBus.$emit('active_activities_updated', this.activitiesData);
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
      const { data } = await axios.get('/activities.json', { params: { tags: this.selected_tags, search: val }, headers: { 'Content-Type': 'application/json' } });
      this.activitiesData = data.activities;
      eventBus.$emit('active_activities_updated', this.activitiesData);
    }, 1000)
  },
  components: {
    ActivityCard,
    ActivityList
  }
}
</script>
