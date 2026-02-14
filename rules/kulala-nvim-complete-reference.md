# Kulala.nvim Complete Reference Guide

Kulala.nvim is a powerful HTTP client plugin for Neovim that supports `.http` and `.rest` files.

## Table of Contents
1. [Basic Usage](#basic-usage)
2. [HTTP File Specification](#http-file-specification)
3. [Variables](#variables)
4. [Request Variables](#request-variables)
5. [Cookies](#cookies)
6. [Environment Variables](#environment-variables)
7. [Magic Variables](#magic-variables)
8. [Authentication](#authentication)
9. [Shared Blocks](#shared-blocks)
10. [File Operations](#file-operations)
11. [Form Data](#form-data)
12. [Dynamic Environment Variables](#dynamic-environment-variables)
13. [Testing and Reporting](#testing-and-reporting)
14. [GraphQL](#graphql)
15. [gRPC](#grpc)
16. [WebSockets](#websockets)
17. [Custom Curl Flags](#custom-curl-flags)
18. [Public Methods](#public-methods)
19. [Import/Export](#importexport)
20. [API Events](#api-events)
21. [Scripts](#scripts)
22. [Recipes](#recipes)

---

## Basic Usage

### Default Keymaps
- `<CR>` or `<leader>Rs` - Run request under cursor
- `<leader>Ra` - Run all requests in buffer
- `<C-c>` - Cancel request execution
- `<leader>Rf` - Search for request in buffer
- `<leader>Ro` - Open Kulala UI
- `<leader>Rb` - Open scratch buffer
- `<leader>Re` - Choose variables environment
- `<leader>Ru` - Manage authentication configurations
- `<leader>Rg` - Download GraphQL schema
- `<leader>Rj` - Open cookie jar file

### UI Navigation
- `H` - Headers view
- `B` - Body view
- `A` - All view
- `V` - Verbose view
- `S` - Stats view
- `O` - Script output
- `R` - Report view
- `[` / `]` - Scroll through response history
- `X` - Clear response history
- `<CR>` - Jump to request in buffer
- `?` - Open help window

### Comments
- `#` or `//` - Comment out lines

### Request Delimiters
- `###` - Separate requests
- `### RequestName` - Name a request for reference

---

## HTTP File Specification

### Request Formats

**Absolute format:**
```http
GET https://example.com:8080/api/data?param=value HTTP/1.1
```

**Origin format:**
```http
GET /api/data
Host: example.com
```

**Multiline URL:**
```http
GET http://example.com:8080
    /api
    /endpoint
    ?id=123
    &value=test
```

### HTTP Methods
- `OPTIONS`, `GET`, `HEAD`, `POST`, `PUT`, `PATCH`, `DELETE`, `TRACE`, `CONNECT`
- `GRAPHQL` - GraphQL requests
- `GRPC` - gRPC requests
- `WS` - WebSocket connections

### HTTP Versions
- `HTTP/1.1`, `HTTP/2`, `HTTP/3` (optional)

### Schemes
- `http`, `https`, `ws`, `wss`

### Request Headers
```http
GET https://example.com/api
Content-Type: application/json
Accept: application/json
Cookie: session=abc123
```

### Request Body
```http
POST https://example.com/api
Content-Type: application/json

{
  "name": "John",
  "age": 30
}
```

---

## Variables

### Document Variables
```http
@hostname=localhost
@port=8080
@host={{hostname}}:{{port}}

GET https://{{host}}/api
```

### Prompt Variables
```http
# @prompt username
# @secret password
GET https://api.example.com/login?user={{username}}
```

### Variable Scope
- Default: `document` scope (available in all requests)
- Optional: `request` scope (configure with `variables_scope = "request"`)

---

## Request Variables

### Syntax
```
{{REQUEST_NAME.(response|request).(body|headers).(*|JSONPath|XPath|HeaderName)}}
```

### Examples
```http
### LOGIN
POST https://api.example.com/login
Content-Type: application/json

{"username": "user", "password": "pass"}

###

GET https://api.example.com/profile
Authorization: Bearer {{LOGIN.response.body.$.token}}
```

### Headers Access
```http
{{REQUEST_NAME.response.headers['Content-Type']}}
{{REQUEST_NAME.response.headers.Date}}
{{REQUEST_NAME.response.headers.HeaderName[0]}}  # Multiple values
```

### Cookie Access
```http
{{REQUEST_NAME.response.cookies.CookieName.value}}
{{REQUEST_NAME.response.cookies.CookieName.domain}}
{{REQUEST_NAME.response.cookies.CookieName.path}}
{{REQUEST_NAME.response.cookies.CookieName.expires}}
```

---

## Cookies

### Setting Cookies
```http
POST https://example.com/api
Cookie: session=abc123
Cookie: token=xyz789
```

### Cookie Jar
- Cookies are persisted to `cookie.txt` in Kulala's cache directory
- Use `# @attach-cookie-jar` to attach cookies from jar
- Use `# @no-cookie-jar` to skip cookie storage for a request

---

## Environment Variables

### http-client.env.json (Recommended)
```json
{
  "$schema": "https://raw.githubusercontent.com/mistweaverco/kulala.nvim/main/schemas/http-client.env.schema.json",
  "dev": {
    "API_URL": "https://dev.example.com",
    "API_KEY": ""
  },
  "prod": {
    "API_URL": "https://prod.example.com",
    "API_KEY": ""
  }
}
```

### http-client.private.env.json (For Secrets)
```json
{
  "dev": {
    "API_KEY": "secret_dev_key"
  },
  "prod": {
    "API_KEY": "secret_prod_key"
  }
}
```

### Default Headers
```json
{
  "$shared": {
    "$default_headers": {
      "Content-Type": "application/json",
      "Accept": "application/json"
    }
  }
}
```

### .env File (Alternative)
```
API_URL=https://example.com
API_KEY=your-api-key
```

### Resolution Order
1. System environment variables
2. http-client.env.json
3. .env file

### Switching Environments
```lua
require('kulala').set_selected_env('prod')
require('kulala').set_selected_env()  -- Opens selector
```

---

## Magic Variables

```http
{{$uuid}}        -- Generates UUID
{{$timestamp}}   -- Generates timestamp
{{$date}}        -- Generates date (yyyy-mm-dd)
{{$randomInt}}   -- Random integer (0-9999999)
```

---

## Authentication

### Basic Authentication
```http
GET https://api.example.com
Authorization: Basic {{Username}}:{{Password}}
# or Base64 encoded:
Authorization: Basic TXlVc2VyOlByaXZhdGU=
```

### Digest Authentication
```http
GET https://api.example.com
Authorization: Digest {{Username}}:{{Password}}
```

### NTLM Authentication
```http
GET https://api.example.com
Authorization: NTLM {{Username}}:{{Password}}
# or current user:
Authorization: NTLM
```

### Negotiate (SPNEGO)
```http
GET https://api.example.com
Authorization: Negotiate
```

### Bearer Token
```http
### login
POST {{loginURL}}
Content-Type: application/x-www-form-urlencoded

client_id={{ClientId}}&client_secret={{ClientSecret}}&grant_type=client_credentials

###

GET {{apiURL}}/items
Authorization: Bearer {{login.response.body.$.access_token}}
```

### OAuth 2.0
```http
POST {{loginURL}}
Authorization: Bearer {{$auth.token("auth-id")}}
```

OAuth config in http-client.env.json:
```json
{
  "dev": {
    "Security": {
      "Auth": {
        "my-auth": {
          "Type": "OAuth2",
          "Grant Type": "Authorization Code",
          "Auth URL": "https://auth.example.com/authorize",
          "Token URL": "https://auth.example.com/token",
          "Client ID": "your-client-id",
          "Redirect URL": "http://localhost:1234",
          "Scope": "read write"
        }
      }
    }
  }
}
```

Grant Types: `Authorization Code`, `Client Credentials`, `Device Authorization`, `Implicit`, `Password`

### AWS Signature V4
```http
GET {{apiUrl}}/
Authorization: AWS <access-key-id> <secret-access-key> token:<session-token> region:<region> service:<service>
```

### SSL Client Certificates
```lua
opts = {
  certificates = {
    ["localhost"] = {
      cert = vim.fn.stdpath("config") .. "/certs/localhost.crt",
      key = vim.fn.stdpath("config") .. "/certs/localhost.key",
    },
  },
}
```

### Disable Certificate Verification
In http-client.private.env.json:
```json
{
  "dev": {
    "SSLConfiguration": {
      "verifyHostCertificate": false
    }
  }
}
```

---

## Shared Blocks

### Shared Block (runs once before all)
```http
### Shared

@shared_var = value
# @curl-location
# @curl-connect-timeout 20

< ./pre_request.js

###

### Request 1
GET https://example.com/api
```

### Shared Each Block (runs before each request)
```http
### Shared each

@token = {{$auth.token("my-auth")}}

###
```

---

## File Operations

### Reading File Data
```http
POST https://example.com/upload
Content-Type: application/json

< /path/to/data.json
```

### Redirect Response to File
```http
GET https://example.com/data

>> response.json      # Don't overwrite if exists
>>! response.json     # Overwrite if exists
```

---

## Form Data

### URL-Encoded Form
```http
@name=John
@age=30

POST https://example.com/form
Content-Type: application/x-www-form-urlencoded

name={{name}}&age={{age}}
```

### Multipart Form
```http
POST https://example.com/upload
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary{{$timestamp}}

------WebKitFormBoundary{{$timestamp}}
Content-Disposition: form-data; name="file"; filename="photo.jpg"
Content-Type: image/jpeg

< /path/to/photo.jpg

------WebKitFormBoundary{{$timestamp}}
Content-Disposition: form-data; name="description"

My photo
------WebKitFormBoundary{{$timestamp}}--
```

---

## Dynamic Environment Variables

### From Response Headers
```http
### REQUEST_ONE
POST https://example.com/api

###

POST https://example.com/api2
Content-Type: {{REQUEST_ONE.response.headers['Content-Type']}}
```

### From Response JSON
```http
### REQUEST_ONE
POST https://example.com/login

###

GET https://example.com/profile
Authorization: Bearer {{REQUEST_ONE.response.body.$.token}}
```

### Using External Commands
```http
# @env-stdin-cmd JWT_CONTEXT jq -r '.token | split(".") | .[1] | @base64d | fromjson | .ctx'
POST https://example.com/api
```

---

## Testing and Reporting

### Assert Functions
```javascript
assert(value, message?)                    // Truthy check
assert.true(value, message?)               // True check
assert.false(value, message?)              // False check
assert.same(value, expected, message?)     // Equality check
assert.hasString(value, expected, message?) // Substring check
assert.responseHas(key, expected, message?) // Response key check
assert.headersHas(key, expected, message?)  // Header check
assert.bodyHas(expected, message?)          // Body contains check
assert.jsonHas(key, expected, message?)     // JSON key check (dot notation)
```

### Test Example
```http
POST https://example.com/api
Content-Type: application/json

{"name": "John"}

> {%
  client.test("API Test Suite", function() {
    assert(response.responseCode === 200, "Status is 200")
    assert.jsonHas("name", "John", "Name is correct")
    assert.headersHas("Content-Type", "application/json")
  });
%}
```

### Reporting Options
```lua
opts = {
  halt_on_error = false,
  show_request_summary = true,
  disable_script_print_output = false,
  ui = {
    report = {
      show_script_output = true,     -- true | false | "on_error"
      show_asserts_output = true,    -- true | false | "on_error" | "failed_only"
      show_summary = true,
    }
  }
}
```

---

## GraphQL

```http
GRAPHQL https://api.example.com/graphql
Accept: application/json

query Person($id: ID) {
  person(personID: $id) {
    name
  }
}

{ "id": 1 }
```

Download schema: `<leader>Rg` or `:lua require("kulala").download_graphql_schema()`

---

## gRPC

**Requires:** `grpcurl` installed

```http
### Shared
# @grpc-import-path ../protos
# @grpc-proto helloworld.proto

###

GRPC localhost:50051 helloworld.Greeter/SayHello
Content-Type: application/json

{"name": "world"}

###

# @grpc-plaintext
GRPC localhost:50051 describe helloworld.Greeter

###

# @grpc-v
GRPC localhost:50051 list
```

---

## WebSockets

**Requires:** `websocat` installed

```http
WS wss://echo.websocket.org

{"message": "hello"}
```

- Messages received are prefixed with `=>`
- Type message and press `<CR>` to send
- `<C-c>` to close connection

---

## Custom Curl Flags

```http
# @curl-compressed
# @curl-location
# @curl-insecure
# @curl-connect-timeout 30

GET https://example.com/api
```

Common flags:
- `# @curl-compressed` - Auto decompress
- `# @curl-location` - Follow redirects
- `# @curl-insecure` - Skip SSL verification
- `# @curl-connect-timeout N` - Connection timeout

---

## Public Methods

```lua
local kulala = require('kulala')

kulala.run()                    -- Run current request
kulala.run_all()                -- Run all requests
kulala.replay()                 -- Replay last request
kulala.open()                   -- Open UI
kulala.inspect()                -- Inspect current request
kulala.show_stats()             -- Show statistics
kulala.scratchpad()             -- Open scratchpad
kulala.copy()                   -- Copy as cURL
kulala.from_curl()              -- Parse cURL from clipboard
kulala.close()                  -- Close kulala window
kulala.toggle_view()            -- Toggle body/headers
kulala.search()                 -- Search named requests
kulala.jump_prev()              -- Jump to previous request
kulala.jump_next()              -- Jump to next request
kulala.set_selected_env('env')  -- Set environment
kulala.get_selected_env()       -- Get current environment
kulala.scripts_clear_global()   -- Clear global variables
kulala.clear_cached_files()     -- Clear cache
kulala.download_graphql_schema() -- Download GraphQL schema
kulala.generate_bug_report()    -- Generate bug report
```

---

## Import/Export

### Import (from Postman, OpenAPI, Bruno)
```lua
require("kulala").import()          -- Auto-detect format
require("kulala").import("postman") -- Explicit format
```

Or use "Convert to HTTP" code action in json/yaml/bruno files.

### Export (to Postman)
```lua
require("kulala").export()       -- Current file
require("kulala").export(path)   -- Specific path
```

---

## API Events

```lua
-- After next request (one-time)
require('kulala.api').on("after_next_request", function(data)
  vim.print("Headers: " .. data.headers)
  vim.print("Body: " .. data.body)
end)

-- After every request
require('kulala.api').on("after_request", function(data)
  vim.print(data.response.status)
end)
```

### Response Data Structure
```lua
---@class Response
---@field id number
---@field url string
---@field method string
---@field status number
---@field duration number
---@field body string
---@field headers string
---@field errors string
---@field stats string
```

---

## Scripts

### Pre-request Script (JavaScript)
```http
< {%
  console.log("Pre-request");
  request.variables.set("TOKEN", "abc123");
%}

< ./pre-request.js

GET https://example.com/api
```

### Post-request Script (JavaScript)
```http
GET https://example.com/api

> {%
  console.log(response.responseCode);
  client.global.set("RESULT", response.body.data);
%}

> ./post-request.js
```

### Lua Scripts
```http
< {%
  -- lua
  client.log("Pre-request")
  request.environment.Token = "abc123"
  client.global.RESULT = "value"
%}

GET https://example.com/api

> {%
  -- lua
  if response.response_code == 401 then
    request.replay()
  end
%}
```

### Client Object
```javascript
client.global.set("key", "value")  // Set global variable
client.global.get("key")           // Get global variable
client.log("message")              // Log message
client.test("name", fn)            // Define test suite
client.assert.*                    // Assertions
client.exit()                      // Exit script
client.clear("key")                // Clear variable
client.clearAll()                  // Clear all variables
```

### Request Object
```javascript
request.variables.get("key")       // Get request variable
request.variables.set("key", val)  // Set request variable
request.body.getRaw()              // Raw body
request.body.tryGetSubstituted()   // Body with variables
request.environment.get("key")     // Get env variable
request.headers.all()              // All headers
request.headers.findByName("name") // Find header
request.method()                   // HTTP method
request.url.getRaw()               // Raw URL
request.url.tryGetSubstituted()    // URL with variables
request.skip()                     // Skip request
request.replay()                   // Replay request
request.iteration()                // Replay count
```

### Response Object
```javascript
response.responseCode              // HTTP status code
response.body                      // Body (string or JSON)
response.headers.valueOf("name")   // Header value
response.headers.valuesOf("name")  // All header values
```

---

## Recipes

### File Upload
```http
@filename = photo.png
@filepath = ./assets/photo.png
@content_type = image/png

POST https://example.com/upload
Content-Type: multipart/form-data; boundary=----Boundary{{$timestamp}}

------Boundary{{$timestamp}}
Content-Disposition: form-data; name="file"; filename="{{filename}}"
Content-Type: {{content_type}}

< {{filepath}}

------Boundary{{$timestamp}}--
```

### Browser-based Auth with CSRF
```http
### Acquire_Token
GET localhost:8000/login

> {%
  -- lua
  client.global.token = response.cookies["XSRF-TOKEN"].value
  client.global.decoded_token = vim.uri_decode(client.global.token)
  client.global.session = response.cookies["session"].value
%}

### Login
POST localhost:8000/login
Content-Type: application/json
X-Xsrf-Token: {{decoded_token}}
Cookie: XSRF-TOKEN={{token}}
Cookie: session={{session}}

{"email": "user@example.com", "password": "pass"}

> {%
  -- lua
  client.global.session = response.cookies["session"].value
%}

### Dashboard
run #Acquire_Token
run #Login

GET http://localhost:8000/dashboard
Cookie: session={{session}}
```

### Iterate Over Response Items
```http
### Get_Items
POST https://example.com/api
Content-Type: application/json

{"action": "list"}

### Process_Item
< {%
  -- lua
  local response = client.responses["Get_Items"].json
  if not response then return end
  
  local item = response.results[request.iteration()]
  if not item then return request.skip() end
  
  request.url_raw = request.environment.url .. "?id=" .. item.id
%}

@url = https://example.com/process
GET {{url}}

> {%
  -- lua
  request.replay()
%}
```

### Modify JSON Body Dynamically
```http
< {%
  -- lua
  local json = require("kulala.utils.json")
  local body = json.parse(request.body)
  body.timestamp = os.time()
  request.body_raw = json.encode(body)
%}

POST https://example.com/api

{"data": "value"}
```

---

## Metadata Reference

| Directive | Description |
|-----------|-------------|
| `# @name value` | Arbitrary metadata |
| `# @prompt var prompt` | Prompt for input |
| `# @secret var prompt` | Hidden input prompt |
| `# @accept chunked` | Accept chunked/streamed responses |
| `# @curl-*` | Curl flags |
| `# @grpc-*` | gRPC flags |
| `# @stdin-cmd command` | Execute external command |
| `# @stdin-cmd-pre command` | Pre-request external command |
| `# @jq filter` | Filter response with jq |
| `# @delay ms` | Delay before request |
| `# @env-stdin-cmd var cmd` | Set env var from command |
| `# @env-json-key var path` | Set env var from JSON path |
| `# @env-header-key var header` | Set env var from header |
| `# @no-cookie-jar` | Don't store cookies |
| `# @attach-cookie-jar` | Attach cookies from jar |

---

## Quick Syntax Reference

```http
### Shared
# Shared variables and scripts apply to all requests

@base_url = https://api.example.com
# @curl-location

###

### MyRequest
# @name Login Request
# @prompt username Enter username
# @secret password Enter password

POST {{base_url}}/login HTTP/1.1
Content-Type: application/json
Accept: application/json

< ./request-body.json

> {%
  client.test("Login Success", function() {
    assert(response.responseCode === 200);
    assert.jsonHas("token", "string");
  });
  client.global.set("token", response.body.token);
%}

>> ./response.json

###

GET {{base_url}}/profile
Authorization: Bearer {{token}}
```

---

## Import and Run Syntax

Kulala supports importing and running requests from other `.http` files:

```http
# Import requests from another file
import ./other-requests.http

# Run a specific named request
run #RequestName

# Run all requests in a file
run ./path/to/file.http

# Run with variable overrides
run #RequestName (@host=example.com, @token=abc123)
```

---

## Script Working Directory

| Script Type | Working Directory |
|------------|-------------------|
| Inline scripts | Directory of the `.http` file |
| External scripts | Directory of the script file |

---

## Key Notes

1. **Lua indicator**: Add `-- lua` at start of script block
2. **Variable scope**:
   - `request.variables` / `request.environment` - current request only
   - `client.global` - persists across requests and Neovim restarts
3. **Modify raw values**: Use `request.url_raw`, `request.headers_raw`, `request.body_raw`
4. **Access previous responses**: `client.responses["Request_name"]`
5. **Clear globals**: `:lua require('kulala').scripts_clear_global('VAR_NAME')`
6. **Script output**: Enable `script_output` in `default_winbar_panes` config
7. **Crypto module**: `require("kulala.cmd.crypto")` for JWT/PKCE generation
8. **Mixing languages**: Lua and JavaScript cannot be mixed in the same request
