-- Daily Coin NPC = "SnGq0A1eXNK6iHdFKTr6h1X0EPlnfpNE9GlUnswERPc"

json = require "json"
sqlite3 = require('lsqlite3')

RewardDb = RewardDb or sqlite3.open_memory()

DAILY_COIN_REDEEM = [[
  CREATE TABLE IF NOT EXISTS Rewards (
    WalletId TEXT ,
    Timestamp INTEGER NOT NULL
  );
]]

RewardDb:exec(DAILY_COIN_REDEEM)

CHAT_TARGET = "GvLWh-oAIsA9e5KF5WpsuPcErJQJMK8KuL_NBl5t-is"
TIMESTAMP_LAST_MESSAGE_MS = TIMESTAMP_LAST_MESSAGE_MS or 0
COOLDOWN_MS = 25000

FUN_COIN_PROCESS = "8RPiT1KlfJA0CCV1-Ize3Uhux6u7_zusbijWabJqink"

function getting_player_data(WalletId)
    local daily_user_schema = {}

    for row in RewardDb:nrows(string.format([[SELECT * FROM Rewards WHERE WalletId = "%s";]], WalletId)) do
        table.insert(daily_user_schema, row)
    end
    if ((#daily_user_schema >= 2) and (((daily_user_schema[#daily_user_schema].Timestamp) - (daily_user_schema[#daily_user_schema - 1].Timestamp)) < 86400000)) then
        Send({
            Target = CHAT_TARGET,
            Tags = {
                Action = 'ChatMessage',
                ['Author-Name'] = 'Jolly Jester',
                Recipient = WalletId,
            },
            Data =
            "You've already got today's token! Come back tomorrow for another! ",
        })
        return true
    else
        return false
    end
end

Handlers.add('Schema', Handlers.utils.hasMatchingTag('Action', 'Schema'), function(msg)
    print('Schema')
    if ((msg.Timestamp - TIMESTAMP_LAST_MESSAGE_MS) < COOLDOWN_MS) then
        return
    end

    RewardDb:exec(string.format([[INSERT INTO Rewards VALUES ("%s","%s");]], msg.From, msg.Timestamp))

    local already = getting_player_data(msg.From)

    if (already == true) then
        Send({
            Target = msg.From,
            Tags = { Type = 'Schema' },
            Data = json.encode({
                ["Jolly Jester"] = {
                    Title = "The Token Tinkerer",
                    Description =
                    "Ah, I see you've already had your fill of tokens today! Come back tomorrow, and I'll have another ready for you!",
                    Schema = nil,
                },
            })
        })


        return
    end


    -- else

    Send({
        Target = msg.From,
        Tags = {
            Type = 'Schema'
        },
        Data = json.encode({
            ["Jolly Jester"] = {
                Title = "The Token Tinkerer",
                Description =
                "Step right up, my friend! I'm the Jolly Jester, and I've got a token of fun just for you! Come back tomorrow for more delightful surprises!",
                Schema = {
                    Tags = json.decode([[
{
"type": "object",
"required": [
  "Action","Recipient",
],
"properties": {
  "Action": {
    "type": "string",
    "const": "redeemCoin"
  },
   "Recipient": {
      "type": "string",
      "const": "]] .. msg.From .. [["
    },
}
}
]]),
                },
            }
        })
    })

    -- end
    TIMESTAMP_LAST_MESSAGE_MS = msg.Timestamp
end)

Handlers.add('redeemCoin', Handlers.utils.hasMatchingTag('Action', 'redeemCoin'), function(msg)
    ao.send({ Target = FUN_COIN_PROCESS, Action = "Transfer", Recipient = msg.Recipient, Quantity = "1" })

    Send({
        Target = CHAT_TARGET,
        Tags = {
            Action = 'ChatMessage',
            ['Author-Name'] = 'Jolly Jester',
            Recipient = msg.Recipient,
        },
        Data =
        " Congrats! You've claimed today's token. See you tomorrow for more fun!",
    })
end)
