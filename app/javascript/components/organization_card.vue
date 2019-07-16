<template>
  <div class="organization-card">
    <div v-for="organizationGroup in organizationsData">
      <div class="row display-flex">
        <div v-for="organization in organizationGroup" class="col-lg-4 center">
          <div class="col-lg-12 center individual-card" v-bind:class="organizationState">
            <h3>
              <a v-bind:href="`/organizations/${organization.id}`">{{ organization.name }}</a>
            </h3>
            <p>
              <a v-if="admin" v-bind:href="`/organizations/${organization.id}/edit`">Edit</a>
            </p>
            <div class="btn btn-secondary btn-sm btn-static" v-for="tag in organization.tag_list">{{ tag }}</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import _ from 'lodash';
import { eventBus } from '../packs/organizations';
export default {
  props: {
    organizations: {
      type: Array
    },
    organizationState: {
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
      organizationsData: _.chunk(this.organizations, 3)
    }
  },
  created: function () {
    eventBus.$on(`${this.organizationState}_organizations_updated`, organizations => {
      this.organizationsData = _.chunk(organizations, 3)
    });
  }
}
</script>
