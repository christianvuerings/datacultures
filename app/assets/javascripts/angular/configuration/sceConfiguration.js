/**
 * Set the SCE configuration
 */
(function(angular) {
  'use strict';

  // Set the configuration
  angular.module('datacultures.config').config(['$sceDelegateProvider', function($sceDelegateProvider) {
    $sceDelegateProvider.resourceUrlWhitelist([
      'self',
      // Youtube
      'http://www.youtube.com/**',
      'https://www.youtube.com/**',
      // Vimeo
      'http://player.vimeo.com/**',
      'https://player.vimeo.com/**'
    ]);
  }]);
})(window.angular);
