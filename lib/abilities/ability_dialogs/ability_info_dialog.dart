import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../ability_objects/ability.dart';

Color? inner = Colors.grey[800];
Color? outer = Colors.grey[850];
showAbilityDialog(BuildContext context, Ability ability) {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: outer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      contentPadding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _heading(ability.baseName, ability.name, ability.description),
            _mainTop(),
          ],
        ),
      ],
    ),
  );
}

_mainTop() {
  return Container(
    padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
    color: outer,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'name',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'desc',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

//name should be the base name of the ability
_heading(String? name, url, desc) {
  return Container(
    padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
    color: outer,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 80,
          width: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl:
                  'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/abilities/$url.png',
              placeholder: (context, url) => const CircularProgressIndicator(),
              //$LATER$ make sure progess indicator appears centered and right size
              errorWidget: (context, url, error) =>
                  Center(child: Text(error.toString().substring(0, 4))),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: desc,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
