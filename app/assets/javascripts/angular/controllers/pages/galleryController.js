(function(angular) {
  'use strict';

  angular.module('datacultures.controllers').controller('GalleryController', function(galleryFactory, userInfoFactory, $scope, $routeParams) {

    $scope.itemId = $routeParams.itemId;

    userInfoFactory.me().success(function(data) {
      $scope.currentUser = data;
    }).then(function() {
      return galleryFactory.getSubmissions().success(function(results) {
        $scope.items = results.files;
      });
    });

    // FILTER & MODULES

    $scope.moduleOptions = {
      types: [
        {display: 'All Modules', name: 'All'},
        {display: 'Module 1', name: 1},
        {display: 'Module 2', name: 2},
        {display: 'Module 3', name: 3}
      ]
    };

    $scope.filterOptions = {
      types: [
        {display: 'All Types', name: 'All Types'},
        {display: 'Image', name: 'image'},
        {display: 'Video', name: 'video'},
        {display: 'Other', name: 'other'}
      ]
    };

    $scope.appliedFilters = {
      filters: []
    };

    $scope.filterModules = {
      types: $scope.moduleOptions.types[0]
    };

    $scope.filterGallery = {
      types: $scope.filterOptions.types[0]
    };

    $scope.customFilter = function(items) {
      $scope.appliedFilters.filters.push({
        type: $scope.filterGallery.types.name,
        module: $scope.filterModules.types.name
      });

      if (($scope.filterGallery.types.name === 'All Types') && ($scope.filterModules.types.name === 'All')) {
        return true;
      }
      if ($scope.filterGallery.types.name === 'All Types' && items.module === $scope.filterModules.types.name) {
        return true;
      }
      if ($scope.filterModules.types.name === 'All' && items.type === $scope.filterGallery.types.name) {
        return true;
      }
      if ($scope.filterGallery.types.name !== 'All Types') {
        if (items.type === $scope.filterGallery.types.name && items.module === $scope.filterModules.types.name) {
          return true;
        }
      }
      if ($scope.filterModules.types.name !== 'All') {
        if (items.type === $scope.filterGallery.types.name && items.module === $scope.filterModules.types.name) {
          return true;
        }
      }
    };

    // SORTING

    $scope.sortOptions = [
      {display: 'Unsorted', type: 'naturalOrder'},
      {display: 'Comments', type: 'numComments'},
      {display: 'Date', type: 'date'},
      {display: 'Likes', type: 'numLikes'},
      {display: 'Views', type: 'numViews'}
    ];

    $scope.sortGallery = 'naturalOrder';

    $scope.switch = function(type) {
      $scope.sortGallery = type.type;
    };

      // COUNT VIEWS

    $scope.countViews = function(id) {
      $scope.items[id].numViews++;
    };

      // LIKE FUNCTION

    $scope.like = function(id) {
      if ($scope.items[id].disliked === 'Un-Dislike') {
        $scope.items[id].likeDisabled = true;
      } else {
        if ($scope.items[id].liked === 'Like') {
          $scope.items[id].numLikes++;
          $scope.items[id].liked = 'Unlike';
          $scope.items[id].dislikeDisabled = true;
          $scope.items[id].hasLike = true;
        } else {
          $scope.items[id].numLikes--;
          $scope.items[id].liked = 'Like';
          $scope.items[id].dislikeDisabled = false;
          $scope.items[id].hasLike = false;
        }
      }
    };

    // DISLIKE FUNCTION

    $scope.dislike = function(id) {
      if ($scope.items[id].liked === 'Unlike') {
        $scope.items[id].dislikeDisabled = true;
      } else {
        if ($scope.items[id].disliked === 'Dislike') {
          $scope.cont = window.confirm('Are you sure? Disliking a post will cause you to lose points too!');
          if ($scope.cont === false) {
            return;
          }
          $scope.items[id].numDislikes++;
          $scope.items[id].disliked = 'Un-Dislike';
          $scope.items[id].likeDisabled = true;
          $scope.items[id].hasDislike = true;
        } else {
          $scope.items[id].numDislikes--;
          $scope.items[id].disliked = 'Dislike';
          $scope.items[id].likeDisabled = false;
          $scope.items[id].hasDislike = false;
        }
      }
    };

    // ADD COMMENT
    $scope.emptyComment = '';
    $scope.insertComment = function(photoID) {
      if ($scope.item.commentContent === null) {
        $scope.emptyComment = 'Please enter your name & comment!';
        return;
      }
      $scope.item.comments.push({
        numComments: $scope.item.comments.length,
        photoID: photoID,
        commentID: $scope.item.comments.length,
        threadView: 'Show Thread',
        showThread: false,
        replyThread: false,
        thread: [],
        author: $scope.currentUser.name,
        content: $scope.item.commentContent
      });
      $scope.item.commentContent = null;
      $scope.item.numComments++;
      $scope.emptyComment = '';

      galleryFactory.createComment($scope.item.comments.slice(-1)[0]).
        success(function() {}).
        error(function() {
          window.alert('The Data did not send. Check your internet connection');
        });

      galleryFactory.getComments(photoID).success(function(results) {
        $scope.item.comments = results;
      });
    };

    // THREADED COMMENTS
    $scope.showThread = false;
    $scope.toggleThread = function(photoID, commentID) {
      if ($scope.item.comments[commentID].threadView === 'Show Thread') {
        $scope.item.comments[commentID].showThread = true;
        $scope.item.comments[commentID].threadView = 'Hide Thread';
      } else {
        $scope.item.comments[commentID].showThread = false;
        $scope.item.comments[commentID].threadView = 'Show Thread';
      }
    };

    // THREADED REPLIES
    $scope.replyThread = 'Toggle Reply';

    $scope.showReplyThread = function(photoID, commentID) {
      $scope.commentID = '';
      if ($scope.item.comments[commentID].replyThread === false) {
        $scope.item.comments[commentID].replyThread = true;
      } else {
        $scope.item.comments[commentID].replyThread = false;
      }
    };

    $scope.emptyReply = '';
    $scope.submitReplyThread = function(photoID, commentID) {
      if ($scope.item.comments[commentID].commentContent === null) {
        $scope.emptyReply = '';
        return;
      }
      $scope.item.comments[commentID].thread.push({
        author: $scope.currentUser.name,
        content: $scope.item.comments[commentID].commentContent
      });
      $scope.emptyReply = '';
      $scope.item.comments[commentID].showThread = true;
      $scope.item.comments[commentID].replyThread = false;
      $scope.item.comments[commentID].threadView = 'Hide Thread';
      $scope.item.comments[commentID].commentContent = null;

      galleryFactory.createComment($scope.item.comments[commentID]).
        success(function() {}).
        error(function() {
          window.alert('The Data did not send. Check your internet connection');
        });
    };

    // RESET COMMENT FORM
    $scope.resetForm = function(element) {
      document.getElementById(element).reset();
    };

    // HAS DESCRIPTION
    $scope.hasDescription = function(itemId) {
      if ($scope.items[itemId].description === 'None') {
        return false;
      } else {
        return true;
      }
    };
  });

})(window.angular);
