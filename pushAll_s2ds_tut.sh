rm -rf data/online_courses_progress_time_s2ds_tut.root*
ut=`date -d "2020-07-04 15:53:00+02:00" +%s`; ./online_courses_progress.sh -push_s2ds_tut $ut
ut=`date -d "2020-07-05 00:00:00+02:00" +%s`; ./online_courses_progress.sh -push_s2ds_tut $ut
ut=`date -d "2020-07-06 00:00:00+02:00" +%s`; ./online_courses_progress.sh -push_s2ds_tut $ut
./online_courses_progress.sh -plot_s2ds_tut
