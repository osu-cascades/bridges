<template>
  <div class="activity-list">
    <div v-for="activity in activitiesData">
      <div class="row p-2" v-bind:class="activityState">
        <div class="col">
          <a v-on:click="select(activity.id)" v-bind:href="`/activities/${activity.id}`">{{ activity.title }}</a>
        </div>
        <div class="col">
          <div class="btn btn-secondary btn-sm btn-static" v-for="tag in activity.tag_list">{{ tag }}</div>
        </div>
        <div class="col-1" v-if="admin">
          <p><a v-bind:href="`/activities/${activity.id}/edit`">Edit</a></p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import _ from 'lodash';
import { eventBus } from '../packs/activities';
export default {
  props: {
    activities: {
      type: Array
    },
    activityState: {
      type: String,
      validator: (state) => ['pending', 'active', 'denied'].includes(state)
    },
    admin: {
      type: Boolean,
      required: true
    }
  },
  data: function () {
    return {
      activitiesData: this.activities
    }
  },
  created: function () {
    eventBus.$on(`${this.activityState}_activities_updated`, activities => {
      this.activitiesData = activities
    });
  }
}
</script>
