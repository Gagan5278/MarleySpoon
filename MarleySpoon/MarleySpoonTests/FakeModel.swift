//
//  FakeModel.swift
//  MarleySpoonTests
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import Foundation
@testable import MarleySpoon

class FakeModel {
    //
    static let fakeImageURLString = "https://image.freepik.com/free-vector/broken-frosted-glass-realistic-icon_1284-12125.jpg"
    //Faking Data
    fileprivate class func createFakeRecipeListData() -> Data {
        let fakeRepoListModel = Data("""
        {
            "sys": {
                "type": "Array"
            },
            "items": [{
                "sys": {
                    "space": {
                        "sys": {
                            "type": "Link"
                        }
                    },
                    "id": "4dT8tcb6ukGSIg2YyuGEOm",
                    "environment": {
                        "sys": {
                            "id": "master"
                        }
                    },
                    "revision": 2,
                    "contentType": {
                        "sys": {
                            "id": "recipe"
                        }
                    },
                    "locale": "en-US"
                },
                "fields": {
                    "title": "Hey Title",
                    "photo": {
                        "sys": {
                            "type": "Link",
                            "linkType": "Asset",
                            "id": "67890pqrstu"
                        }
                    },
                    "calories": 788,
                    "description": "*Hey this is description",
                    "tags": [{
                        "sys": {
                            "type": "Link",
                            "linkType": "Entry",
                            "id": "123456abcdef"
                        }
                    }]
                }
            }],
            "includes": {
                "Entry": [{
                    "sys": {
                        "space": {
                            "sys": {
                                "type": "Link",
                                "linkType": "Space",
                                "id": "kk2bw5ojx476"
                            }
                        },
                        "id": "123456abcdef",
                        "type": "Entry",
                        "environment": {
                            "sys": {
                                "id": "master",
                                "type": "Link",
                                "linkType": "Environment"
                            }
                        },
                        "revision": 2,
                        "contentType": {
                            "sys": {
                                "type": "Link",
                                "linkType": "ContentType",
                                "id": "chef"
                            }
                        },
                        "locale": "en-US"
                    },
                    "fields": {
                        "name": "Mark Zucchiniberg "
                    }
                }],
                "Asset": [{
                    "sys": {
                        "space": {
                            "sys": {
                                "type": "Link",
                                "linkType": "Space",
                                "id": "kk2bw5ojx476"
                            }
                        },
                        "id": "67890pqrstu",
                        "type": "Asset",
                        "environment": {
                            "sys": {
                                "id": "master",
                                "type": "Link",
                                "linkType": "Environment"
                            }
                        },
                        "revision": 1,
                        "locale": "en-US"
                    },
                    "fields": {
                        "title": "SKU1503 Hero 102 1 -6add52eb4eec83f785974ddeac3316b7",
                        "file": {
                            "url": "//images.ctfassets.net/kk2bw5ojx476/3TJp6aDAcMw6yMiE82Oy0K/2a4cde3c1c7e374166dcce1e900cb3c1/SKU1503_Hero_102__1_-6add52eb4eec83f785974ddeac3316b7.jpg",
                            "details": {
                                "size": 216391,
                                "image": {
                                    "width": 1020,
                                    "height": 680
                                }
                            },
                            "fileName": "SKU1503_Hero_102__1_-6add52eb4eec83f785974ddeac3316b7.jpg",
                            "contentType": "image/jpeg"
                        }
                    }
                }]
            }
        }
        """.utf8)
        return fakeRepoListModel
    }

    //MARK:- get Fake  model
    class func getRecipeListFakeModel() -> Items?
    {
        let data = FakeModel.createFakeRecipeListData()
        do {
            let decoder = JSONDecoder()
            let genericModel = try decoder.decode(Items.self, from: data)
            return genericModel
        } catch  {
            print(error)
            return nil
        }
    }
}
