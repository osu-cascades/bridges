<template>
  <div class="activity-card">
    <div v-for="activityGroup in activitiesData">
      <div class="row display-flex">
        <div v-for="activity in activityGroup" class="col-lg-4 center">
          <div class="col-lg-12 center individual-card" v-bind:class="activityState">
            <h3>
              <a v-bind:href="`/activities/${activity.id}`">{{ activity.title }}</a>
            </h3>
            <p>
              <a v-if="admin" v-bind:href="`/activities/${activity.id}/edit`">Edit</a>
            </p>
            <div class="btn btn-secondary btn-sm btn-static" v-for="tag in activity.tag_list">{{ tag }}</div>
          </div>
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
      activitiesData: _.chunk(this.activities, 3)
    }
  },
  created: function () {
    eventBus.$on(`${this.activityState}_activities_updated`, activities => {
      this.activitiesData = _.chunk(activities, 3)
    });
  }
}
</script>
