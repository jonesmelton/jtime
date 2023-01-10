(import testament :as t)
(import ../jtime/init :as date)

(t/deftest
 string->datetime
 (t/assert-equal {:date "14" :month "01" :time "13:35:10" :year 2023}
                 (date/read "Wed Jan  14 13:35:10 2023")
                 "double-digit day")

 (t/assert-equal {:date "04" :month "10" :time "13:35:10" :year 2023}
                 (date/read "Wed Oct  4 13:35:10 2023")
                 "double-digit day"))

(t/deftest
 datetime->string

 (t/assert-equal "2023-01-14 13:35:10"
                 (date/produce-datetime  {:date "14" :month "01" :time "13:35:10" :year 2023})
                 "generates string")

 (t/assert-equal "2023-10-04 13:35:10"
                 (date/parse "Wed Oct  4 13:35:10 2023")
                 "full production"))

(t/run-tests!)
