// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileMediaModel {
  String image;
  bool isVideo;
  ProfileMediaModel({
    required this.image,
    required this.isVideo,
  });
}

List<ProfileMediaModel> media = [
  ProfileMediaModel(
    image: 'assets/media/media3.png',
    isVideo: false,
  ),
  ProfileMediaModel(
    image: 'assets/media/media4.png',
    isVideo: false,
  ),
  ProfileMediaModel(
    image: 'assets/media/media5.png',
    isVideo: true,
  ),
  ProfileMediaModel(
    image: 'assets/media/media6.png',
    isVideo: false,
  ),
  ProfileMediaModel(
    image: 'assets/media/media7.png',
    isVideo: true,
  ),
];
