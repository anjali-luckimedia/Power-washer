class HomeDataModel {
  String? message;
  String? status;
  Data? data;

  HomeDataModel({this.message, this.status, this.data});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Header? header;
  Banner? banner;
  List<Sections>? sections;
  List<BookServices>? bookServices;
  List<ThoughtfulCuration>? thoughtfulCuration;

  Data(
      {this.header,
        this.banner,
        this.sections,
        this.bookServices,
        this.thoughtfulCuration});

  Data.fromJson(Map<String, dynamic> json) {
    header =
    json['header'] != null ? new Header.fromJson(json['header']) : null;
    banner =
    json['banner'] != null ? new Banner.fromJson(json['banner']) : null;
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
    if (json['book_services'] != null) {
      bookServices = <BookServices>[];
      json['book_services'].forEach((v) {
        bookServices!.add(new BookServices.fromJson(v));
      });
    }
    if (json['thoughtful_curation'] != null) {
      thoughtfulCuration = <ThoughtfulCuration>[];
      json['thoughtful_curation'].forEach((v) {
        thoughtfulCuration!.add(new ThoughtfulCuration.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header!.toJson();
    }
    if (this.banner != null) {
      data['banner'] = this.banner!.toJson();
    }
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    if (this.bookServices != null) {
      data['book_services'] =
          this.bookServices!.map((v) => v.toJson()).toList();
    }
    if (this.thoughtfulCuration != null) {
      data['thoughtful_curation'] =
          this.thoughtfulCuration!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Header {
  String? title;
  Location? location;

  Header({this.title, this.location});

  Header.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  String? address;
  String? area;

  Location({this.address, this.area});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['area'] = this.area;
    return data;
  }
}

class Banner {
  String? title;
  String? subtitle;
  String? description;
  CtaButton? ctaButton;
  List<String>? carousel;

  Banner(
      {this.title,
        this.subtitle,
        this.description,
        this.ctaButton,
        this.carousel});

  Banner.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    ctaButton = json['ctaButton'] != null
        ? new CtaButton.fromJson(json['ctaButton'])
        : null;
    carousel = json['carousel'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['description'] = this.description;
    if (this.ctaButton != null) {
      data['ctaButton'] = this.ctaButton!.toJson();
    }
    data['carousel'] = this.carousel;
    return data;
  }
}

class CtaButton {
  String? text;
  String? action;

  CtaButton({this.text, this.action});

  CtaButton.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['action'] = this.action;
    return data;
  }
}

class Sections {
  String? title;
  List<SectionsItems>? sectionsItems;

  Sections({this.title, this.sectionsItems});

  Sections.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['sections_items'] != null) {
      sectionsItems = <SectionsItems>[];
      json['sections_items'].forEach((v) {
        sectionsItems!.add(new SectionsItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.sectionsItems != null) {
      data['sections_items'] =
          this.sectionsItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SectionsItems {
  String? name;
  String? icon;

  SectionsItems({this.name, this.icon});

  SectionsItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;
  }
}

class BookServices {
  String? title;
  List<BookServicesItems>? bookServicesItems;

  BookServices({this.title, this.bookServicesItems});

  BookServices.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['book_services_items'] != null) {
      bookServicesItems = <BookServicesItems>[];
      json['book_services_items'].forEach((v) {
        bookServicesItems!.add(new BookServicesItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.bookServicesItems != null) {
      data['book_services_items'] =
          this.bookServicesItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookServicesItems {
  String? name;
  String? servicesType;
  Details? details;
  String? image;

  BookServicesItems({this.name, this.servicesType,this.details, this.image});

  BookServicesItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    servicesType = json['services_type'];
    details = json['details'] != null ? new Details.fromJson(json['details']) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['services_type'] = this.servicesType;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['image'] = this.image;
    return data;
  }
}

class Details {
  double? rating;
  int? reviews;
  String? year;
  String? time;

  Details({this.rating, this.reviews, this.year,this.time});

  Details.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    reviews = json['reviews'];
    year = json['year'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['reviews'] = this.reviews;
    data['year'] = this.year;
    data['time'] = this.time;
    return data;
  }
}

class ThoughtfulCuration {
  String? title;
  String? description;
  List<ThoughtfulCurationItems>? thoughtfulCurationItems;

  ThoughtfulCuration(
      {this.title, this.description, this.thoughtfulCurationItems});

  ThoughtfulCuration.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    if (json['thoughtful_curation_items'] != null) {
      thoughtfulCurationItems = <ThoughtfulCurationItems>[];
      json['thoughtful_curation_items'].forEach((v) {
        thoughtfulCurationItems!.add(new ThoughtfulCurationItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.thoughtfulCurationItems != null) {
      data['thoughtful_curation_items'] =
          this.thoughtfulCurationItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ThoughtfulCurationItems {
  String? image;

  ThoughtfulCurationItems({this.image});

  ThoughtfulCurationItems.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}
