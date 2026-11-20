# flutter_local_notifications saves scheduled alerts with Gson so it can
# re-schedule them after a restart. Keep its classes whole, so a release
# build (shrunk by R8) can still read alerts saved by an earlier version.
# (Gson 2.12, which it uses, brings its own rules for TypeToken.)
-keep class com.dexterous.** { *; }
