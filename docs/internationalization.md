# Internationalization (optional)

If your datacultures provider app is going to be other than just English, add a line to the config/locales/ yaml file for that language with the field 'app_name' -- see the [English locale file](../blob/master/config/locales/en.yml)  for an example.

This is also where the displayed names for the types of points are configured.

An example of the file, the supplied en.yml:

```yaml
en:
  app_name: "Data Cultures LTI application"
  activity_types:
    DiscussionTopic:  'Created a discussion topic'
    DiscussionEdit:   'Edited a discussion topic'
    DiscussionEntry:  'Replied to a discussion'
    Submission:       'Submitted for an assignment'
    GalleryComment:   'Comment on a Gallery Submission'
    Like:             'Liked a Gallery Item'
    Dislike:          'Disliked a Gallery Item'
```
