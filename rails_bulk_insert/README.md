# Ruby on Rails Bulk Record Insertion

This example illustrates how [ActiveRecord#upsert_all](https://api.rubyonrails.org/classes/ActiveRecord/Persistence/ClassMethods.html#method-i-upsert_all) can be used to avoid deadlock.

This example uses a simple data model of a hypothetical registry service for books and their associated authors, publishers, and categories.

## Positive Case

To demonstrate how [#upsert_all](https://api.rubyonrails.org/classes/ActiveRecord/Persistence/ClassMethods.html#method-i-upsert_all) can be used to upsert books and their associated authors, and publishers even when duplicates are present in the input dataset. To execute the example use the following command:

```
bundle exec rake db:bulk_insert_example
```

## Negative Case

To demonstrate how concurrent writes to the database upserting records can cause deadlocks.  To execute the example use the following command:

```
bundle exec rake db:deadlock_example
```



