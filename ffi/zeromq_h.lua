local ffi = require("ffi")

ffi.cdef[[
typedef struct _zctx_t zctx_t;
typedef struct _zmsg_t zmsg_t;
typedef struct _zhash_t zhash_t;
typedef struct _zsock_t zsock_t;
typedef struct _zframe_t zframe_t;
typedef struct _zpoller_t zpoller_t;
typedef struct _zyre_t zyre_t;
typedef struct _zre_msg_t zre_msg_t;
typedef struct _zyre_event_t zyre_event_t;
typedef enum {
  ZYRE_EVENT_ENTER = 1,
  ZYRE_EVENT_JOIN = 2,
  ZYRE_EVENT_LEAVE = 3,
  ZYRE_EVENT_EXIT = 4,
  ZYRE_EVENT_WHISPER = 5,
  ZYRE_EVENT_SHOUT = 6,
} zyre_event_type_t;
zyre_t *zyre_new(void);
void zyre_destroy(zyre_t **);
const char *zyre_uuid(zyre_t *);
const char *zyre_name(zyre_t *);
void zyre_set_name(zyre_t *, const char *);
void zyre_set_header(zyre_t *, const char *, const char *, ...);
void zyre_set_verbose(zyre_t *);
void zyre_set_port(zyre_t *, int);
void zyre_set_interval(zyre_t *, unsigned int);
void zyre_set_interface(zyre_t *, const char *);
int zyre_start(zyre_t *);
void zyre_stop(zyre_t *);
int zyre_join(zyre_t *, const char *);
int zyre_leave(zyre_t *, const char *);
zmsg_t *zyre_recv(zyre_t *);
int zyre_whisper(zyre_t *, const char *, zmsg_t **);
int zyre_shout(zyre_t *, const char *, zmsg_t **);
int zyre_whispers(zyre_t *, const char *, const char *, ...);
int zyre_shouts(zyre_t *, const char *, const char *, ...);
zsock_t *zyre_socket(zyre_t *);
void zyre_dump(zyre_t *);
zyre_event_t *zyre_event_new(zyre_t *);
void zyre_event_destroy(zyre_event_t **);
zyre_event_type_t zyre_event_type(zyre_event_t *);
char *zyre_event_sender(zyre_event_t *);
char *zyre_event_name(zyre_event_t *);
char *zyre_event_address(zyre_event_t *);
char *zyre_event_header(zyre_event_t *, char *);
char *zyre_event_group(zyre_event_t *);
int zmq_getsockopt(void *, int, void *, unsigned int *) __attribute__((visibility("default")));
zctx_t *zctx_new(void);
void zctx_destroy(zctx_t **);
void *zsocket_new(zctx_t *, int);
int zsocket_connect(void *, const char *, ...);
void zsocket_set_identity(void *, const char *);
char *zsocket_identity(void *);
void zsocket_destroy(zctx_t *, void *);
zframe_t *zframe_recv(void *);
unsigned int zframe_size(zframe_t *);
unsigned char *zframe_data(zframe_t *);
zmsg_t *zmsg_new(void);
unsigned int zmsg_size(zmsg_t *);
int zmsg_addmem(zmsg_t *, const void *, unsigned int);
int zmsg_send(zmsg_t **, void *);
char *zmsg_popstr(zmsg_t *);
void zstr_free(char **);
zframe_t *zmsg_pop(zmsg_t *);
zhash_t *zhash_unpack(zframe_t *);
void *zhash_first(zhash_t *);
void *zhash_next(zhash_t *);
char *zhash_cursor(zhash_t *);
void *zhash_lookup(zhash_t *, const char *);
void zmsg_destroy(zmsg_t **);
void zhash_destroy(zhash_t **);
void zframe_destroy(zframe_t **);
zpoller_t *zpoller_new(void *, ...);
void zpoller_destroy(zpoller_t **);
int zpoller_add(zpoller_t *, void *);
void *zpoller_wait(zpoller_t *, int);
_Bool zpoller_expired(zpoller_t *);
_Bool zpoller_terminated(zpoller_t *);
typedef struct _fmq_server_t fmq_server_t;
typedef struct _fmq_client_t fmq_client_t;
fmq_server_t *fmq_server_new(void);
void fmq_server_destroy(fmq_server_t **);
void fmq_server_configure(fmq_server_t *, const char *);
void fmq_server_setoption(fmq_server_t *, const char *, const char *);
int fmq_server_bind(fmq_server_t *, const char *);
void fmq_server_publish(fmq_server_t *, const char *, const char *);
void fmq_server_set_anonymous(fmq_server_t *, long int);
fmq_client_t *fmq_client_new(void);
void fmq_client_destroy(fmq_client_t **);
void fmq_client_configure(fmq_client_t *, const char *);
void fmq_client_setoption(fmq_client_t *, const char *, const char *);
void fmq_client_connect(fmq_client_t *, const char *);
zmsg_t *fmq_client_recv(fmq_client_t *);
void *fmq_client_handle(fmq_client_t *);
void fmq_client_subscribe(fmq_client_t *, const char *);
void fmq_client_set_inbox(fmq_client_t *, const char *);
void fmq_client_set_resync(fmq_client_t *, long int);
]]
