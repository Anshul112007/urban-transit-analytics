import pandas as pd
import random
from datetime import datetime, timedelta
import os

# Set up some basic variables
routes = ['R01', 'R02', 'R03', 'R04', 'R05']
delay_reasons = ['On-Time', 'Traffic Congestion', 'High Boarding', 'Signal Delay', 'Mechanical']

data = []
base_time = datetime(2023, 10, 1, 6, 0, 0) # Starting at 6:00 AM

# Generate about 5000 rows
for i in range(5000):
    route = random.choice(routes)
    trip_id = f"{route}_T{random.randint(1, 100)}"
    stop_id = f"S{random.randint(1, 20)}"
    stop_sequence = random.randint(1, 20)
    
    # Add random minutes to the base time for scheduled arrival
    scheduled_arrival = base_time + timedelta(minutes=random.randint(1, 1000))
    
    # Pick a random delay reason
    reason = random.choices(
        delay_reasons, 
        weights=[0.6, 0.15, 0.15, 0.05, 0.05], 
        k=1
    )[0]
    
    # Assign delay seconds based on the reason
    if reason == 'On-Time':
        delay_seconds = random.randint(-60, 300)
    elif reason == 'Traffic Congestion':
        delay_seconds = random.randint(300, 1200)
    elif reason == 'High Boarding':
        delay_seconds = random.randint(60, 400)
    elif reason == 'Signal Delay':
        delay_seconds = random.randint(60, 300)
    else: # Mechanical
        delay_seconds = random.randint(600, 3600)
        
    actual_arrival = scheduled_arrival + timedelta(seconds=delay_seconds)
    passenger_load = random.randint(5, 80)
    
    # Append to our data list
    data.append({
        'trip_id': trip_id,
        'route_id': route,
        'stop_id': stop_id,
        'stop_sequence': stop_sequence,
        'scheduled_arrival': scheduled_arrival,
        'actual_arrival': actual_arrival,
        'delay_seconds': delay_seconds,
        'passenger_load': passenger_load,
        'delay_reason': reason
    })

# Convert to DataFrame
df = pd.DataFrame(data)

# Sort by scheduled arrival so it looks like a real timeline
df = df.sort_values('scheduled_arrival').reset_index(drop=True)

# Save to CSV
output_path = os.path.join(os.path.dirname(__file__), 'transit_stop_logs.csv')
df.to_csv(output_path, index=False)

print("Data generation complete!")
print(f"Saved {len(df)} rows to {output_path}")
