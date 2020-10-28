import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_text_config.dart';
import 'package:ihm_2020_3/src/model/entity/component/info_object.dart';

class DamageTextObject extends InfoObject{

  DamageTextObject(CustomSpriteEntity entity): super(entity, "-1 VIDA!");

}

class RightAnswerTextObject extends InfoObject{

  RightAnswerTextObject(CustomSpriteEntity entity): super(entity, "ACERTOU!");

  TextConfig get textConfig => CustomTextConfig(
      fontSize: 12.0,
      color: const Color(0xFF335d2d),
      fontStyle: FontStyle.italic);

}
