from kafka import KafkaConsumer
from kafka import TopicPartition

kafkaServer = '10.211.55.58'
kafkaPort = 9092
kafkaHost = ['{0}:{1}'.format(kafkaServer, kafkaPort)]
topic = 'test01'

consumer = KafkaConsumer(topic, bootstrap_servers=kafkaHost)
for message in consumer:
    #print(message)
    print ("%s:%d:%d: key=%s value=%s timestamp=%d" % (message.topic, message.partition,
                                          message.offset, message.key,
                                          message.value, message.timestamp))
