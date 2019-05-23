<template>
  <div class="activity-card">
    <div v-for="activity in activitiesData">
      <div class="col-lg-4 center">
        <div class="col-lg-12 center">
          <h3>
            <a v-on:click="select(activity.id)" v-bind:href="`/activities/${activity.id}`">{{ activity.title }}</a>
          </h3>
          <p>
            <a v-bind:href="`/activities/${activity.id}/edit`">Edit</a>
          </p>
          <div class="btn btn-secondary btn-sm btn-static" v-for="tag in activity.tag_list">{{ tag }}</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { eventBus } from '../packs/activities_dashboard';
export default {
  props: {
    activities: {
      type: Array,
      required: true
    }
  },
  data: function () {
    return {
      activitiesData: this.activities
    }
  },
  created: function () {
    eventBus.$on('activities_updated', activities => {
      this.activitiesData = activities
    });
  }
}
</script>
