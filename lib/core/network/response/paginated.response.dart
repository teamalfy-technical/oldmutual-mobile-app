class PaginatedResponse<T> {
  List<T>? data;
  PaginationLinks? links;
  PaginationMeta? meta;

  PaginatedResponse({this.data, this.links, this.meta});

  PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    data = json['data'] != null
        ? (json['data'] as List).map((e) => fromJsonT(e)).toList()
        : null;
    links = json['links'] != null
        ? PaginationLinks.fromJson(json['links'])
        : null;
    meta = json['meta'] != null
        ? PaginationMeta.fromJson(json['meta'])
        : null;
  }

  Map<String, dynamic> toJson(Object? Function(T value)? toJsonT) {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['data'] = data != null && toJsonT != null
        ? data!.map((e) => toJsonT(e)).toList()
        : null;
    json['links'] = links?.toJson();
    json['meta'] = meta?.toJson();
    return json;
  }
}

class PaginationLinks {
  String? first;
  String? last;
  String? prev;
  String? next;

  PaginationLinks({this.first, this.last, this.prev, this.next});

  PaginationLinks.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['last'] = last;
    data['prev'] = prev;
    data['next'] = next;
    return data;
  }
}

class PaginationMeta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<PaginationLink>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  PaginationMeta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  PaginationMeta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    links = json['links'] != null
        ? (json['links'] as List)
            .map((e) => PaginationLink.fromJson(e))
            .toList()
        : null;
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['links'] = links?.map((e) => e.toJson()).toList();
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class PaginationLink {
  String? url;
  String? label;
  bool? active;

  PaginationLink({this.url, this.label, this.active});

  PaginationLink.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
