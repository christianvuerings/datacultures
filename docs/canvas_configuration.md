# Configuring Canvas

The LTI tokens that are used to communicate between the Data Cultures LTI provider and the Canvas consumer must be generated. There is a thor task for this:

```shell
cd datacultures
thor keys:lti_new
```

The new keys will print out. In the browser with Canvas open, and while logged in as a teacher, go to the course, select the settings tab on the left, click the Applications tab in the middle of the screen, click on Add application.

In the dialog that appears, change the configuration type drop-down to 'By URL'. For the URL field, you must list the location where Canvas can access DataCultures, and the port, e.g., 'http://learn.berkeley.edu:5000' + the URLs for the LTI 'app'. The title here for each 'app' is only for this listing. The link on the left side of the nav bar will be taken from the generated XML that is parsed by Canvas. Do this for each app. The last part of the URL to append to the base are as follows:

* /canvas/lti_points_configuration
* /canvas/lti_engagement_index
* /canvas/lti_gallery

For the app key, use the value printed out above under 'thor keys:lti_new', and the same for the app secret.
