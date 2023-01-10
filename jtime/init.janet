(defn- month-replacer [month-name]
  (case month-name
    "jan" "01"
    "feb" "02"
    "mar" "03"
    "apr" "04"
    "may" "05"
    "jun" "06"
    "jul" "07"
    "aug" "08"
    "sep" "09"
    "oct" "10"
    "nov" "11"
    "dec" "12"))

(defn- day-replacer [day]
  (let [day-num (parse day)]
  (if (< 9 day-num)
    (string day-num)
    (string "0" day-num))))

(def- date-grammar
  ~{
    :day :w+
    :sep ":"
    :month (* (constant :month) (replace (capture :w+) ,month-replacer))
    :date (* (constant :date) (replace (capture (at-most 2 :d)) ,day-replacer))
    :time  (* (constant :time) (capture (* :d+ :sep :d+ :sep :d+)))
    :year (* (constant :year) (replace (capture (4 :d)) ,parse))
    :main (cmt (* :day
             :s+
             :month
             :s+
             :date
             :s+
             :time
             :s+
             :year
             (to -1)) ,struct)
    })

(defn read
  `parses date and time out of a string like "Wed Jan  14 13:35:10 2023"`
  [date-string]
  (let [date (string/ascii-lower date-string)]
    (first (peg/match date-grammar date))))

(defn produce-datetime
  `makes a sqlite-compliant datetime in the format "YYYY-MM-DD HH:MM:SS".
  NOTE: expected 1-based counting for month and day, where janet produces 0-based.
  `
  [date]
  (string/format "%d-%s-%s %s"
                 (date :year)
                 (date :month)
                 (date :date)
                 (date :time)))

(defn parse
  `converts "humanized" datetime string into sqlite-compatible format`
  [date-string]
  (-> date-string
      (read)
      (produce-datetime)))

(defn main
  [& args]
  (parse args))
