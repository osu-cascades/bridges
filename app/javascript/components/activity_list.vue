<template>
  <div class="activity-list">
    <ul class="list-group">
      <div v-for="activity in activitiesData" class="col-lg-4 center">
        <li class="list-group-item">
          <a v-on:click="select(activity.id)" v-bind:href="`/activities/${activity.id}`">{{ activity.title }}</a>
          <p><a v-if="admin" v-bind:href="`/activities/${activity.id}/edit`">Edit</a></p>
          <div class="btn btn-secondary btn-sm btn-static" v-for="tag in activity.tag_list">{{ tag }}</div>
        </li>
      </div>
    </ul>
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
