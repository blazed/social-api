PAPERCLIP_PHOTO_OPTIONS = {
  path: "/:class/:attachment/:id/:style/:fingerprint.:extension",
  #url:  "http://localhost:3000/uploads/:class/:attachment/:id/:style/:fingerprint.:extension",
  styles: {
    tiny:     '25x25#',
    xsmall:   '70x70#',
    small:    'x212',
    medium:   '500x500>',
    large:    '800x800',
    original: '1600x1600>',
    photos: '192x192#'
  },
  convert_options: {
    all: '-quality 75 -strip'
  },
  default_url: "http://localhost:3000/assets/profile_:style.jpg",
}

PAPERCLIP_PHOTO_MAX_SIZE = 50.megabytes
PAPERCLIP_PHOTO_CONTENT_TYPES = ['image/jpeg', 'image/jpg', 'image/pjpeg', 'image/png', 'image/x-png']

PAPERCLIP_BACKGROUND_OPTIONS = {
  path: ":rails_root/public/uploads/:class/:attachment/:id/:style/:fingerprint.:extension",
  url:  "http://localhost:3000/uploads/:class/:attachment/:id/:style/:fingerprint.:extension",
  styles: {
    medium:   '930x300#',
    original: '1600x1600',
  },
  convert_options: {
    all: '-quality 75 -strip'
  },
  default_url: "http://localhost:3000/assets/background_:style.jpg",
}

PAPERCLIP_BACKGROUND_MAX_SIZE = 50.megabytes
PAPERCLIP_BACKGROUND_CONTENT_TYPES = ['image/jpeg', 'image/jpg', 'image/pjpeg', 'image/png', 'image/x-png']

PAPERCLIP_FILE_OPTIONS = {
  path: ":rails_root/public/uploads/:class/:attachment/:id/:fingerprint.:extension",
  url:  "/uploads/:class/:attachment/:id/:fingerprint.:extension"
}

PAPERCLIP_FILE_MAX_SIZE = 50.megabytes

Paperclip.registered_attachments_styles_path = "#{Rails.root}/tmp/paperclip_attachments.yml"

