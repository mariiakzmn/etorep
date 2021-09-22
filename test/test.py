from connectors import ConnectorRouter
import pandas as pd
import datetime

API_KEY = ''
SECRET_KEY = ''
balance = 100
client = ConnectorRouter(exchange='Binance', section='SPOT').init_connector(API_KEY, SECRET_KEY)
klines = client.get_klines("ETHUSDT", '1M')
prices = [dict['close'] for dict in klines]
first_price = prices[0]
timestamp = [dict['openTime'] for dict in klines]

blnc = [balance * (cur_price / first_price) for cur_price in prices]
df = pd.DataFrame(np.array([timestamp, blnc),
                   columns=['timestamp', 'balance'])
                            
                     
                            
