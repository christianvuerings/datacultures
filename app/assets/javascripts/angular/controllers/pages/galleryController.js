(function(angular) {
  'use strict';

  angular.module('datacultures.controllers').controller('GalleryController', function(galleryFactory, $scope, $routeParams) {

    $scope.imageID = $routeParams.imageID;

    galleryFactory.getSubmissions().success(function(results) {
      $scope.items = results.files;
      $scope.currentUser = results.files.slice(-1)[0];
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
      filters: [
      ]
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
      if ($scope.items[photoID].commentContent === null) {
        $scope.emptyComment = 'Please enter your name & comment!';
        return;
      }
      $scope.items[photoID].comments.push({
        numComments: 0,
        photoID: photoID,
        commentID: $scope.items[photoID].numComments,
        threadView: 'Show Thread',
        showThread: false,
        replyThread: false,
        thread: [],
        author: $scope.currentUser.name,
        content: $scope.items[photoID].commentContent
      });
      $scope.items[photoID].commentContent = null;
      $scope.items[photoID].numComments++;
      $scope.emptyComment = '';

      galleryFactory.createComment($scope.items[photoID].comments.slice(-1)[0]).
        success(function() {}).
        error(function() {
          window.alert('The Data did not send. Check your internet connection');
        });
    };

    // THREADED COMMENTS
    $scope.showThread = false;
    $scope.toggleThread = function(photoID, commentID) {
      if ($scope.items[photoID].comments[commentID].threadView === 'Show Thread') {
        $scope.items[photoID].comments[commentID].showThread = true;
        $scope.items[photoID].comments[commentID].threadView = 'Hide Thread';
      } else {
        $scope.items[photoID].comments[commentID].showThread = false;
        $scope.items[photoID].comments[commentID].threadView = 'Show Thread';
      }
    };

    // THREADED REPLIES
    $scope.replyThread = 'Toggle Reply';

    $scope.showReplyThread = function(photoID, commentID) {
      $scope.commentID = '';
      if ($scope.items[photoID].comments[commentID].replyThread === false) {
        $scope.items[photoID].comments[commentID].replyThread = true;
      } else {
        $scope.items[photoID].comments[commentID].replyThread = false;
      }
    };

    $scope.emptyReply = '';
    $scope.submitReplyThread = function(photoID, commentID) {
      if ($scope.items[photoID].comments[commentID].commentContent === null) {
        $scope.emptyReply = '';
        return;
      }
      $scope.items[photoID].comments[commentID].thread.push({
        author: $scope.currentUser.name,
        content: $scope.items[photoID].comments[commentID].commentContent
      });
      $scope.emptyReply = '';
      $scope.items[photoID].comments[commentID].showThread = true;
      $scope.items[photoID].comments[commentID].replyThread = false;
      $scope.items[photoID].comments[commentID].threadView = 'Hide Thread';
      $scope.items[photoID].comments[commentID].commentContent = null;

      galleryFactory.createComment($scope.items[photoID].comments[commentID]).
        success(function() {}).
        error(function() {
          window.alert('The Data did not send. Check your internet connection');
        });
    };

    // RESET COMMENT FORM
    $scope.resetForm = function(element) {
      document.getElementById(element).reset();
    };

    // VIDEO PROCESSING

    $scope.isVideo = function(imageID) {
      return ($scope.items[imageID].type === 'video');
    };

    $scope.VID = 0;
    $scope.fetchVID = function(imageID) {
      $scope.VID = $scope.items[imageID].VID;
    };

    // HAS DESCRIPTION

    $scope.hasDescription = function(imageID) {
      if ($scope.items[imageID].description === 'None') {
        return false;
      } else {
        return true;
      }
    };

    // FULL VIEW NAVIGATION

    $scope.prevItem = '#';
    $scope.nextItem = '#';
    $scope.fetchPreviousNext = function(imageID) {
      if (imageID === 0) {
        $scope.testPrev = '#';
        $scope.nextType = $scope.items[1].type;
        $scope.nextItem = '../' + $scope.nextType + 1;
      } else if ($scope.items[imageID] !== null) {
        $scope.prevID = parseFloat(imageID) - parseFloat(1);
        $scope.prevType = $scope.items[$scope.prevID].type;
        $scope.prevItem = '../' + $scope.prevType + $scope.prevID;
        $scope.nextID = parseFloat(imageID) + parseFloat(1);
        $scope.nextType = $scope.items[$scope.nextID].type;
        $scope.nextItem = '../' + $scope.nextType + $scope.nextID;
      }
    };
  });

})(window.angular);
