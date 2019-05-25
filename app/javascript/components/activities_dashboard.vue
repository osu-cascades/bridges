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
    </nav>
    <div class="container">
      <ActivityCard :activities="activitiesData"></ActivityCard>
    </div>
  </div>
</template>

<script>
import { eventBus } from '../packs/activities';
import ActivityCard from './activity_card';
import axios from 'axios';

export default {
  name: "ActivitiesDashboard",
  props: {
    activities: {
      type: Array,
      required: true
    },
    tags: {
      type: Array,
      required: true
    }
  },
  data: function () {
    return {
      search: '',
      selected_tags: [],
      tagsData: this.tags,
      activitiesData: this.activities
    }
  },
  methods: {
    select: async function (tag) {
      const indexOfTag = this.selected_tags.indexOf(tag.name);
      indexOfTag === -1 ?
        this.selected_tags.push(tag.name) :
        this.selected_tags.splice(indexOfTag, 1);
      const { data } = await axios.get('/activities.json', { params: { tags: this.selected_tags }, headers: { 'Content-Type': 'application/json' } });
      this.activitiesData = data;
      eventBus.$emit('activities_updated', this.activitiesData);
    },
    clearTags: async function () {
      const { data } = await axios.get('/activities.json', { headers: { 'Content-Type': 'application/json' } });
      this.activitiesData = data;
      this.selected_tags = [];
      eventBus.$emit('activities_updated', this.activitiesData);
    },
    active: function (tag) {
      return this.selected_tags.includes(tag.name)  ? 'active' : '';
    }
  },
  watch: {
    search: _.debounce(async function (val) {
      const { data } = await axios.get('/activities.json', { params: { tags: this.selected_tags, search: val }, headers: { 'Content-Type': 'application/json' } });
      this.activitiesData = data;
      eventBus.$emit('activities_updated', this.activitiesData);
    }, 1000)
  },
  components: {
    ActivityCard
  }
}
</script>
