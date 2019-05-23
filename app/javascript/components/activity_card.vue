<template>
  <container>
    <div class="col-lg-4 center" v-for="activity in activities">
      <div class="col-lg-12 center">
        <h3>{{ activity.title }}</h3>
        <p>Edit</p>
        <button class="btn btn-secondary btn-sm" v-for="tag in activity.tag_list">{{ tag }}</button>
      </div>
    </div>
  </container>
</template>

<script>
export default {
  props: {
    activities: {
      type: Array,
      required: true
    }
  },
  methods: {
    select: function(id) {
      console.log('selecting id', id);
    },
    edit: function(id) {
      console.log('editing id', id);
    }
  }
}
</script>

<style lang="scss" scoped>

</style>