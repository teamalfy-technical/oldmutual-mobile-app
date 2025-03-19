/// -- Declare all app icons here
const appLogoSVG = 'app.logo.svg';
const userIcon = 'person.icon.svg';
const userBorderIcon = 'person.border.icon.svg';
const passwordInvisibleIcon = 'password.invisible.svg';
//const rightIcon = 'Right-Icon.svg';
const arrowLeftIcon = 'arrow-left.svg';
const checkCircleFillIcon = 'check-circle-fill.svg';
const emailIcon = 'email.icon.svg';
const addIcon = 'add.icon.svg';
const addCircleIcon = 'circle.add.icon.svg';
const profileIcon = 'profile.icon.svg';
//const userIcon = 'Left Icon.svg';
const passwordIcon = 'password.icon.svg';
const closeIcon = 'close.icon.svg';
const checkWhiteIcon = 'check.white.icon.svg';
const patchCheckIcon = 'patch.check.icon.svg';
const notificationIcon = 'notification.icon.svg';
const homeIcon = 'house.fill.svg';
const searchIcon = 'search.fill.svg';
const gymIcon = 'gym.fill.svg';
const chatIcon = 'chat.fill.svg';
const profileHomeIcon = 'profile.fill.svg';
const menuIcon = 'menu.icon.svg';
const likeIcon = 'like.icon.svg';
const dislikeIcon = 'dislike.icon.svg';
const commentIcon = 'comment.icon.svg';
const shareIcon = 'share.icon.svg';
const gymBuddieIcon = 'gym.buddie.svg';
const arrowDownIcon = 'arrow.down.icon.svg';
const searchOutlinedIcon = 'search.icon.svg';
const barcodeIcon = 'barcode.icon.svg';
const arrowRightIcon = 'arrow.right.icon.svg';
const editIcon = 'edit.icon.svg';
const deleteIcon = 'delete.icon.svg';
const clockIcon = 'clock.icon.svg';
const calendarIcon = 'calendar.icon.svg';
const photoIcon = 'photo.icon.svg';
const blockIcon = 'block.icon.svg';
const pencilSquareIcon = 'pencil.square.icon.svg';
const chatReadIcon = 'chat.read.icon.svg';
const imageIcon = 'image.icon.svg';
const settingIcon = 'setting.icon.svg';
const starIcon = 'star.icon.svg';
const chatOutlinedIcon = 'chat.outlined.icon.svg';
const attachmentIcon = 'attachment.icon.svg';
const copyIcon = 'copy.icon.svg';
const whatsappIcon = 'whatsapp.icon.svg';
const smsIcon = 'sms.icon.svg';

/// -- Declare all app images here
const appLogo = 'app.logo.png';
const floatingImage = 'floating-image.png';
const profileImage = 'profile.img.png';
const gymBuddieImage = 'gym.buddie.png';
const gymBuddieSearchImage = 'gym.buddie.search.png';
const wizkidImage = 'wizkid.img.png';
const davidoImage = 'davido.img.png';

class TAppAssets {
  TAppAssets._();

  static String iconRoot = 'assets/icons/';
  static String imageRoot = 'assets/images/';

  /// -- Returns entire image path
  static String getImagePath(String path) => imageRoot + path;

  /// -- Returns entire icon path
  static String getIconPath(String path) => iconRoot + path;
}
