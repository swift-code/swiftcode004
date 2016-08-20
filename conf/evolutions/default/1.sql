# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table connection_request (
  id                        bigint auto_increment not null,
  sender_id                 bigint,
  receiver_id               bigint,
  status                    varchar(8),
  constraint ck_connection_request_status check (status in ('ACCEPTED','WAITING')),
  constraint pk_connection_request primary key (id))
;

create table profile (
  first_name                varchar(255) not null,
  last_name                 varchar(255),
  company                   varchar(255),
  constraint pk_profile primary key (first_name))
;

create table user (
  id                        bigint auto_increment not null,
  email                     varchar(255),
  password                  varchar(255),
  profile_first_name        varchar(255),
  constraint uq_user_profile_first_name unique (profile_first_name),
  constraint pk_user primary key (id))
;


create table user_connections (
  user_id                        bigint not null,
  connection_id                  bigint not null,
  constraint pk_user_connections primary key (user_id, connection_id))
;
alter table connection_request add constraint fk_connection_request_sender_1 foreign key (sender_id) references user (id) on delete restrict on update restrict;
create index ix_connection_request_sender_1 on connection_request (sender_id);
alter table connection_request add constraint fk_connection_request_receiver_2 foreign key (receiver_id) references user (id) on delete restrict on update restrict;
create index ix_connection_request_receiver_2 on connection_request (receiver_id);
alter table user add constraint fk_user_profile_3 foreign key (profile_first_name) references profile (first_name) on delete restrict on update restrict;
create index ix_user_profile_3 on user (profile_first_name);



alter table user_connections add constraint fk_user_connections_user_01 foreign key (user_id) references user (id) on delete restrict on update restrict;

alter table user_connections add constraint fk_user_connections_user_02 foreign key (connection_id) references user (id) on delete restrict on update restrict;

# --- !Downs

SET FOREIGN_KEY_CHECKS=0;

drop table connection_request;

drop table profile;

drop table user;

drop table user_connections;

SET FOREIGN_KEY_CHECKS=1;

