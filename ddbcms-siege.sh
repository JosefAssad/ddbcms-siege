#!/bin/bash

CONCURRENT_USERS=1
REPETITIONS=1
URL_FILE="./urls.txt"
LOG_FILE="./ddbcms-siege.log"
#BASE_SITES="http://ballerup-tst.ddbcms.dk http://taarnby-tst.ddbcms.dk http://vejle-tst.ddbcms.d"
#BASE_SITES="http://ballerup-tst.ddbcms.dk"
BASE_SITES="http://ddbcms-kursus.dandigbib.org"

for BASE_SITE in $BASE_SITES
do
    # TEST00: Standard search terms
    echo $BASE_SITE"/search/ting/kongens%20fald%20i%20nobelperspektiv"
    echo $BASE_SITE"/search/ting/konventsdannelsen%20i%20fyns%20stift"
    echo $BASE_SITE"/search/ting/%22den%20faderl%C3%B8se%22"
    echo $BASE_SITE"/search/ting/Fuglenes%20%C3%B8kologi%20og%20adf%C3%A6rd"

    # TEST01: Standard search terms, larger (>800) result sets
    echo $BASE_SITE"/search/ting/familien"
    echo $BASE_SITE"/search/ting/sprog"
    echo $BASE_SITE"/search/ting/sl%C3%A6gtsromaner"
    # following is expensive because of broad works
    echo $BASE_SITE"/search/ting/mozart"

    # TEST02: "exotic" searches; uncommon terms
    echo $BASE_SITE"/search/ting/og%20%20og"
    echo $BASE_SITE"/search/ting/og%20%28ord%29"

    # TEST03: Searches with facet-based filtering
    echo $BASE_SITE"/search/ting/Ole%20Lisberg%20Jensen?facets[]=facet.type%3Atidsskriftsartikel"
    echo $BASE_SITE"/search/ting/boy%20girl?facets[]=facet.creator%3Aboy%20meets%20girl"
    echo $BASE_SITE"/search/ting/secret%20%28instrumental%29?sort=title_ascending&facets[]=facet.type%3Anode"

    # TEST04: searches with empty result sets
    echo $BASE_SITE"/search/ting/rock%20musik%20spillet%20og%20sunget%20af%20en%20egyptisk%20gruppe.%20de%20er%20kendt%20for%20deres%20politiske%20lyrik"
    echo $BASE_SITE"/search/ting/%22fl%C3%B8dekaramels%C3%B8ren%22%20%28%22cigarets%C3%B8ren%22%29"

    # TEST05: searches virtually guaranteed to be cache misses end-to-end
    for i in $(seq 5)
    do
	SEARCH_TERM=$(date '+%N' | md5sum | awk -F " " '{print $1}') # just various md5 hashes of the datetime
	echo $BASE_SITE"/search/ting/"$SEARCH_TERM
    done
done > $URL_FILE

./drplsiege.sh -i -c$CONCURRENT_USERS -r$REPETITIONS -l$LOG_FILE -f $URL_FILE
