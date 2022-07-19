import 'package:db_helper/db_helper.dart';

const wrapperTable = 'wrappers';

const id = 'id';
const title = 'title';
const price = 'price';
const imageUrl = 'imageUrl';
const amount = 'amount';
const maxAmount = 'maxAmount';

const wrapperFields = [
  Field(
    title: id,
    type: int,
    nullable: false,
    primary: true,
  ),
  Field(
    title: title,
    type: String,
    nullable: false,
  ),
  Field(
    title: price,
    type: double,
    nullable: false,
  ),
  Field(
    title: imageUrl,
    type: String,
    nullable: false,
  ),
  Field(
    title: amount,
    type: int,
    nullable: false,
  ),
  Field(
    title: maxAmount,
    type: int,
    nullable: false,
  ),
];
