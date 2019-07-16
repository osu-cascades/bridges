<template>
  <div class="organization-list">
    <div v-for="organization in organizationsData">
      <div class="row p-2" v-bind:class="organizationState">
        <div class="col">
          <a v-on:click="select(organization.id)" v-bind:href="`/organizations/${organization.id}`">{{ organization.name }}</a>
        </div>
        <div class="col">
          <div class="btn btn-secondary btn-sm btn-static" v-for="tag in organization.tag_list">{{ tag }}</div>
        </div>
        <div class="col-1" v-if="admin">
          <p><a v-bind:href="`/organizations/${organization.id}/edit`">Edit</a></p>
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
      organizationsData: this.organizations
    }
  },
  created: function () {
    eventBus.$on(`${this.organizationState}_organizations_updated`, organizations => {
      this.organizationsData = organizations
    });
  }
}
</script>
