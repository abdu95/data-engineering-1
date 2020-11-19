
## Challenges

### 1 
The standard CSV place strings in " quotes in order to avoid internal ',' . That's why MySQL was reading some integer values in CSV as string. To solve this problem, I had to remove quotes from CSV. I did this using bash command:

    awk '{gsub(/\"/,"")};1' input.csv 

### 2
But it caused to another error. In row 552, there is a value for seller_city as `novo hamburgo, rio grande do sul, brasil`. That's why MySQL gave Error: "Row 553 contained more data than there were input columns". To fix this problem, I had to replace commas with empty string by simply opening and editing CSV. The same error occured in row 2989. 

### 3
Charset

    ENGINE = InnoDB DEFAULT CHARSET = UTF8MB4;

All the tables should be created using same charset. Otherwise, there will be inconsistency problem in building CONSTRAINT for Foreign Keys.

### 4 

    SET shipping_limit_date = STR_TO_DATE(@v_shipping_limit_date, '%m/%d/%Y %H:%i');


### 5
Remove duplicate keys

112648 lines