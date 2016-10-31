from kafka import KafkaProducer
import datetime
import time

topic = 'test01'
message = b'blah blah blah'
kafkaServer = '10.211.55.58'
kafkaPort = 9092
kafkaHost = ['{0}:{1}'.format(kafkaServer, kafkaPort)]
producer = KafkaProducer(bootstrap_servers=kafkaHost)

def toUnixTime(dt):
    dt1 = datetime.strptime(dt, '%Y-%m-%dT%H:%M:%S.%fZ')
    td = dt1 - datetime.fromtimestamp(0)
    return int(td.total_seconds() * PRECISION)

def fromUnixTime(dt):
    return datetime.fromtimestamp(dt/PRECISION).strftime("%Y-%m-%dT%H:%M:%S.%fZ")



for x in range(100):
    message = b'blah blah blah: {0}'.format(x)
    a = producer.send(topic, value = message, timestamp_ms = int(round(time.time() * 1000)))
    print(a.__dict__)
    print('----------')
    print(a._produce_future.__dict__)
