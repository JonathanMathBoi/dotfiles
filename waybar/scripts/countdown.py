#!/usr/bin/env python3
import json
from datetime import datetime, timezone

# Target: July 8, 2026, at 9:00 AM EDT (UTC-4)
TARGET = datetime(2026, 7, 8, 9, 0, 0).astimezone()

def get_countdown():
    now = datetime.now().astimezone()
    delta = TARGET - now

    if delta.total_seconds() <= 0:
        return {"text": "0m", "tooltip": "Event reached", "class": "expired"}

    total_seconds = int(delta.total_seconds())
    days = total_seconds // 86400
    hours = (total_seconds % 86400) // 3600
    minutes = (total_seconds % 3600) // 60

    # Text throttling based on proximity
    if days > 0:
        text_output = f"{days} days"
    elif hours > 0:
        text_output = f"{hours} hours"
    else:
        text_output = f"{minutes} minutes"

    # Precise breakdown for the hover tooltip
    tooltip_output = f"{days}d {hours}h {minutes}m remaining"

    return {
        "text": text_output,
        "tooltip": tooltip_output,
        "class": "countdown-active"
    }

if __name__ == "__main__":
    print(json.dumps(get_countdown()))
