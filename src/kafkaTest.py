from kafka import KafkaProducer

topic = 'test01'
message = b'blah blah blah'
kafkaServer = '10.211.55.58'
kafkaPort = 9092
kafkaHost = ['{0}:{1}'.format(kafkaServer, kafkaPort)]
#kafkaHost = ['{0}'.format(kafkaServer)]
producer = KafkaProducer(bootstrap_servers=kafkaHost)
for x in range(100):
    message = b'blah blah blah: {0}'.format(x)
    producer.send(topic, message)
