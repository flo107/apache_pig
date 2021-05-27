cd constitution_hdfs
lines = LOAD 'constitution.txt' USING TextLoader AS (line:CHARARRAY);
words = FOREACH lines GENERATE FLATTEN(TOKENIZE(line)) as word;
grouped = GROUP words BY word;
wordcount = FOREACH grouped GENERATE group, COUNT(words) AS count;
orderedcount = ORDER wordcount BY $1 DESC, $0 ASC;
top50 = LIMIT orderedcount 50;
DUMP;
