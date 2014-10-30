# Engagement Index Configuration

[The natural language textual description](internationalization.md)  should first be entered in [config/locales/en.yml or other internationalization file](../blob/master/config/locales/en.yml) if the default English language names are not desired.

If you database does not already have all the required PointsConfiguration data, you must once per instance populate the table (with random point scores). From the project directory:

```shell
rake db:seed
```

[Canvas Configuration](canvas_configuration.md) specifically, configuring Canvas to use Data Cultures as an LTI provider must be completed before the next step is taken.

From Canvas, go to the 'Points Configuration' tab on the left while logged in as an instructor. From there, you can turn off scoring of a category, or change the points associated with it.
