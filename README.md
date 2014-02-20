ddbcms-siege
============

Wrapper for DrupalSiege specifically for DDB CMS

Prerequisites
===========

1. A sane operating system. Debian is sane. OSX can probably mimic sanity for long enough for this to run.
2. Siege
3. Some DDB CMS sites you want to break
4. One common login to the aforementioned DDB CMS sites

You won't need to download DrupalSiege separately; I have taken the wildly irresponsible decision to bundle it with ddbcms-siege.

Setting up
========

1. git clone this repo
2. In the bundled drpsiege.sh file, edit in the common login near the top of the file
3. In ddbcms-siege.sh, edit the concurrency and repettion variables near the top of the file
4. In ddbcms-siege.sh, put the base urls for your DDB CMS sites in the BASE_SITES variable near the top. Spaces separate entries.
5. Check that ddbcms-siege.sh and drplsiege.sh has +x
6. Kill a chicken and invoke ddbcms-siege thusly: ./ddbcms-siege.sh
7. Admire our performant Drupal based library CMS
